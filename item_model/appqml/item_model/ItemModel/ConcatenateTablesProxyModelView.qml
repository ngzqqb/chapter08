import QtQuick 2.13
import QtQuick.Controls 2.13

/*begin:import*/
import theqml_the_debug.item_model_module 1.0
/*end:import*/

PrivateBasic{

    KnowListModel{
        id : idListModel1
        theCount: 1 ;
    }

    KnowListModel{
        id : idListModel2
        theCount: 2 ;
    }

    KnowListModel{
        id : idListModel3
        theCount: 3 ;
    }

    ConcatenateTablesProxyModel{
        id : idConcatenateTablesProxyModel
        Component.onCompleted: {
            idConcatenateTablesProxyModel.addSourceModel(idListModel1);
            idConcatenateTablesProxyModel.addSourceModel(idListModel2);
            idConcatenateTablesProxyModel.addSourceModel(idListModel3);
        }
    }

    ScrollView{
        anchors.fill: parent ;
        ListView{
            delegate: Rectangle {
                color: theBackgroundColor
                height: 32
                width: parent.width
                Text {
                    anchors.centerIn: parent;
                    text: index
                }
            }
            model: idConcatenateTablesProxyModel
        }
    }

}
