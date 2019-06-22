import QtQuick 2.13
import QtQuick.Controls 2.13

/*begin:import*/
import theqml_the_debug.item_model_module 1.0
/*end:import*/

PrivateBasic{

    KnowListModel{
        id : idModel
        theCount: 64
    }

    ItemSelectionModel{
        model: idModel
        id : idSelectModel
        property bool isForceSelectCurrentIndex: false
        function forceSelectCurrentIndex(){
            if(isForceSelectCurrentIndex){
                return;
            }
            try{
                isForceSelectCurrentIndex=true;
                if(idSelectModel.isSelected( idModel.index(idListView.currentIndex,0) ) ){
                    return;
                }
                idSelectModel.select(idModel.index(idListView.currentIndex,0) ,
                                     ItemSelectionModel.Select );
            }finally{
                isForceSelectCurrentIndex=false;
            }
        }
        onSelectionChanged: {
             forceSelectCurrentIndex();
        }
        Component.onCompleted: {
            forceSelectCurrentIndex();
        }
    }

    ScrollView{
        anchors.fill: parent ;
        focus: true
        ListView{
            id : idListView
            highlightFollowsCurrentItem :false
            focus: true
            onCurrentIndexChanged:{
                idSelectModel.select(idModel.index(idListView.currentIndex,0) ,
                                     ItemSelectionModel.ClearAndSelect );
            }
            function viewAtCurrentIndex(){
                 positionViewAtIndex(currentIndex ,ListView.Contain)
            }
            Keys.onUpPressed: {
                event.accepted = false;
                Qt.callLater(viewAtCurrentIndex)
            }
            Keys.onDownPressed: {
                event.accepted = false;
                Qt.callLater(viewAtCurrentIndex)
            }
            Rectangle{
                id : idMaskRectangle
                color: Qt.rgba(0.8,0.2,0.2,0.5)
                visible: false
                property real dragStartX: 1
                property real dragStargY: 1
            }
            delegate  : MouseArea{
                width: parent.width
                height: 32

                onClicked: {
                    if(mouse.modifiers & Qt.ShiftModifier){
                          if( idListView.currentIndex === index ){
                              idBackGround.selectThis();
                              return;
                          }
                          if( index < idListView.currentIndex ){
                              idSelectModel.selectRangePair(idModel.index(index,0) ,
                                                            idModel.index(idListView.currentIndex,0) ,
                                                            ItemSelectionModel.ClearAndSelect );
                          }else{
                              idSelectModel.selectRangePair(idModel.index(idListView.currentIndex,0) ,
                                                            idModel.index(index,0) ,
                                                            ItemSelectionModel.ClearAndSelect );
                          }
                    }else if(mouse.modifiers & Qt.ControlModifier ){
                          idBackGround.addOrRemoveSelect();
                    }else {
                        idListView.currentIndex = index;
                        idBackGround.selectThis();
                    }
                }

                Rectangle{
                    id : idBackGround;
                    anchors.fill: parent;
                    property bool isSelect : checkIsSelect() ;

                    function addOrRemoveSelect(){
                        if(checkIsSelect()){
                            idSelectModel.select(idModel.index(index,0) ,
                                                 ItemSelectionModel.Deselect );
                        }else{
                            idSelectModel.select(idModel.index(index,0) ,
                                                 ItemSelectionModel.Select );
                        }
                    }

                    function selectThis(){
                        idSelectModel.setCurrentIndex(idModel.index(index,0) ,
                                                      ItemSelectionModel.ClearAndSelect)
                    }

                    function checkIsSelect(){
                        var varIndex = idModel.index(index,0);
                        return idSelectModel.isSelected(varIndex)
                    }

                    Connections{
                        target: idSelectModel
                        onSelectionChanged:{
                            idBackGround.isSelect = idBackGround.checkIsSelect() ;
                        }
                    }

                    Text {
                        text: index
                        color: "blue"
                        anchors.centerIn: parent
                    }

                    Rectangle{
                        width: parent.width
                        height: parent.height ;
                        color: "transparent"
                        border.color: idBackGround.isSelect?"lightblue":"black"
                        border.width: 3 ;
                    }

                }
            }

            model: idModel

            MouseArea{
                anchors.fill: parent
                propagateComposedEvents:true
                acceptedButtons: Qt.LeftButton
                Rectangle{
                    id : idNeverUsedRectangle
                    visible: false
                }
                drag.target: idNeverUsedRectangle
                drag.axis : Drag.XAndYAxis
                property bool isPressedAndMove: false ;
                Timer{
                    interval : 100
                    repeat : true
                    running : idDragMouseArea.isPressedAndMove
                    triggeredOnStart :false
                    onTriggered: {
                        var varMouseY = idDragMouseArea.mouseY;
                        idDragMouseArea.selectByArea();
                        if( varMouseY < 0 ){
                            idListView.flick(0, 320);
                            return;
                        }else  if( varMouseY > idListView.height ){
                            idListView.flick(0,-320);
                            return;
                        }
                        idListView.cancelFlick();
                    }
                    onRunningChanged: {
                        if(running){
                            return;
                        }
                        idListView.cancelFlick();
                    }
                }

                function selectByArea(){
                    var varMouseY = idDragMouseArea.mouseY;
                    var varAppY  = varMouseY;
                    if( varMouseY < 1.5 ){
                        varAppY = 1.5 ;
                    } else if( varMouseY > idListView.height ){
                        varAppY = idListView.height - 1.5
                    }
                    var varContentItem = idListView.contentItem;
                    varAppY = idDragMouseArea.mapToItem(varContentItem,1.5,varAppY).y;
                    var varMouseIndex = idListView.indexAt( 1.5 , varAppY );
                    if( varMouseIndex < 0 ){
                        if( varMouseY < 0 ){
                            varMouseIndex = 0;
                        }else{
                            varMouseIndex = idListView.count > 1?(idListView.count-1):0;
                        }
                    }
                    if(varMouseIndex>idListView.currentIndex){
                        idSelectModel.selectRangePair(idModel.index(idListView.currentIndex,0) ,
                                                      idModel.index(varMouseIndex,0) ,
                                                      ItemSelectionModel.ClearAndSelect );
                    }else{
                        idSelectModel.selectRangePair(idModel.index(varMouseIndex,0) ,
                                                      idModel.index(idListView.currentIndex,0),
                                                      ItemSelectionModel.ClearAndSelect );
                    }
                }

                function selectMouseCurrent(argX,argY){
                    var varContentItem = idListView.contentItem;
                    var varAppY = idDragMouseArea.mapToItem(varContentItem,argX,argY).y;
                    var varMouseIndex = idListView.indexAt( 1.5 , varAppY );
                    if( varMouseIndex < 0 ){
                        if( argY < 0 ){
                            varMouseIndex = 0;
                        }else{
                            varMouseIndex = idListView.count > 1?(idListView.count-1):0;
                        }
                    }
                    idListView.currentIndex = varMouseIndex;
                }

                onPositionChanged: {
                    mouse.accepted = false
                    if( pressed ){
                        if(isPressedAndMove===false){
                            isPressedAndMove = true;
                            idMaskRectangle.dragStargY=mouse.y
                            idMaskRectangle.dragStartX=mouse.x
                            idMaskRectangle.visible=true;
                            idDragMouseArea.selectMouseCurrent(mouse.x,mouse.y);
                        }
                        idMaskRectangle.x = Math.min( mouse.x , idMaskRectangle.dragStartX)
                        idMaskRectangle.y = Math.min( mouse.y ,idMaskRectangle.dragStargY )
                        idMaskRectangle.height = Math.abs( mouse.y - idMaskRectangle.dragStargY )
                        idMaskRectangle.width = Math.abs( mouse.x - idMaskRectangle.dragStartX )
                    }
               }
                onReleased: {
                    mouse.accepted = false
                    isPressedAndMove = false;
                    idMaskRectangle.visible=false;
                }
                id : idDragMouseArea
            }

        }

    }

}
