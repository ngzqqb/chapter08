import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import sstd.listview 1.0

PrivateBasic{

    id : idRoot

    GenMoreModel {
        id : idModel
    }

    ColumnLayout{

        anchors.fill: parent

        Label{
            text: idRoot.liveItemCount
        }

        ScrollView{
            Layout.fillHeight: true
            Layout.fillWidth: true
            ListView{

                clip: true
                anchors.fill: parent

                model: idModel
                delegate: Rectangle {
                    color: theBackgroundColor
                    height: 32
                    width: ListView.view.width
                }

            }

        }
    }

}















