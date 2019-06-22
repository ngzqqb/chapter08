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
        function forceSelectCurrentIndex(){
            if(idSelectModel.isSelected( idModel.index(idListView.currentIndex,0) ) ){
              return;
            }
            idSelectModel.select(idModel.index(idListView.currentIndex,0) ,
                                 ItemSelectionModel.Select );
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
        ListView{
            id : idListView
            highlightRangeMode : ListView.StrictlyEnforceRange
            highlightFollowsCurrentItem :false

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
                            idBackGround.isSelect = idBackGround.checkIsSelect();
                        }
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
        }

    }

}
