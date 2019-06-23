import QtQuick 2.13
import QtQuick.Controls 2.13

/*begin:import*/
import theqml_the_debug.item_model_module 1.0
/*end:import*/

PrivateBasic{

    KnowTableModel{
        id: idTableModel
        theColumnSize: 8
        theRowSize: 8
    }

    TransposeProxyModel{
        theModel: idTableModel
        id : idTransposeProxyModel
    }

    ScrollView{
        anchors.fill: parent;
        TableView{
            id : idTableView
            model: idTransposeProxyModel;
            Timer{
                interval: 1500;
                running: true;
                repeat: true
                onTriggered: idTableView.model === idTransposeProxyModel?
                                 idTableView.model=idTableModel :
                                 idTableView.model=idTransposeProxyModel ;
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
                color: theBackgroundColor
                Text {
                    anchors.centerIn: parent
                    text: "( " + row + " , " + column + " )"
                }
            }
        }
    }

}
