import QtQuick 2.13
import QtQuick.Controls 2.13

/*begin:import*/
import theqml_the_debug.item_model_module 1.0
/*end:import*/

PrivateBasic{

     KnowListModel{
         id : idListModel
         theCount: 1024;
     }

     IdentityProxyModel{
         id : idIdentityProxyModel
         theModel : idListModel
         theAttachedText:qsTr("from proxy model")
     }

     Timer{
         interval: 1500;
         running: true;
         repeat: true
         onTriggered: {
             if(idIdentityProxyModel.theAttachedText === qsTr("from proxy model")){
                idIdentityProxyModel.theAttachedText = qsTr("update from proxy model");
             }else{
                idIdentityProxyModel.theAttachedText = qsTr("from proxy model");
             }
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
                    text: theAttachedText
                    color: theForegroundColor
                    font.bold: true
                }
            }
            model: idIdentityProxyModel
        }
    }

}
