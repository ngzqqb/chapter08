import QtQuick 2.13
import QtQuick.Controls 2.13

/*begin:import*/
import theqml_the_debug.item_model_module 1.0
/*end:import*/

PrivateBasic{

    KnowSortFilterModel{
        id : idModel
    }

    SortFilterProxyModel{
        id : idSortModel
        theModel : idModel
    }

    ScrollView{
        anchors.fill: parent;
        TableView{
            id : idTableView
            model: idSortModel ;
            Timer{
                interval: 1500;
                running: true;
                repeat: true
                onTriggered: idTableView.model === idSortModel?
                                 idTableView.model=idModel :
                                 idTableView.model=idSortModel ;
            }
            Component.onCompleted: {
                Qt.callLater(function(){
                    idSortModel.lessThanFunction = function(argLR,argLC,argRR,argRC){
                        var varLeftIndex = idModel.index(argLR,argLC);
                        var varRightIndex = idModel.index(argRR,argRC);
                        var varLeftValue = idModel.data(varLeftIndex , KnowSortFilterModel.Key1 ) ;
                        var varRightValue = idModel.data(varRightIndex , KnowSortFilterModel.Key1 ) ;
                        return varLeftValue > varRightValue;
                    }
                    idSortModel.sort(0)
                })
            }
            columnWidthProvider:function(){
                return width/columns ;
            }
            rowHeightProvider: function(){
                return height/rows;
            }
            function fitTableSize(){
                if(columns>0){
                    if(rows>0){
                        forceLayout() ;
                    }
                }
            }
            onWidthChanged: fitTableSize();
            onHeightChanged: fitTableSize();
            delegate: Rectangle{
                border.color: "black"
                border.width: 1
                color: "white"
                Text {
                    anchors.centerIn: parent
                    text: key1 + " , " + key2 + " , " + key3
                }
            }
        }
    }

}
