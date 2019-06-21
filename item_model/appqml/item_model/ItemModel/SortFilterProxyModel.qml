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
    }

    ScrollView{
        anchors.fill: parent;
        TableView{
            id : idTableView
            model: idModel ;
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


