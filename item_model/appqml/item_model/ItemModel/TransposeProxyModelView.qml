import QtQuick 2.13
import QtQuick.Controls 2.13

/*begin:import*/
import theqml_the_debug.item_model_module 1.0
/*end:import*/

PrivateBasic{

    KnowTableModel{
        id: idTableModel
    }

    ScrollView{
        anchors.fill: parent;
        TableView{
            id : idTableView
            model: idTableModel;
            columnWidthProvider:function(){
                return width/columns ;
            }
            rowHeightProvider: function(){
                return 32
            }
            onWidthChanged: {
                if(columns>0){
                    if(rows>0){
                        forceLayout() ;
                    }
                }
            }
            delegate: Rectangle{
                border.color: "black"
                border.width: 1
                color: theBackgroundColor
                Text {
                    anchors.centerIn: parent
                    text: "( " + row + " , " + column + " )"
                }
            }
        }
    }

}

