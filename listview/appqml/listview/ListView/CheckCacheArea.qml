import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

PrivateBasic{

    id : idRoot
    property int liveItemCount: 0

    ColumnLayout{

        anchors.fill: parent

        Label{
            text: idRoot.liveItemCount
        }

        ListView{

            Layout.fillHeight: true
            Layout.fillWidth: true

            model: 1024 * 1024
            delegate: Rectangle {
                color: Qt.rgba(Math.random(),
                               Math.random(),
                               Math.random(),
                               1 );
                Component.onCompleted: {
                    ++idRoot.liveItemCount
                }
                Component.onDestruction: {
                    --idRoot.liveItemCount
                }
            }

        }

    }

}















