import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import sstd.listview 1.0

PrivateBasic{

    id : idRoot
    property int liveItemCount: 0

    VeryLargeModel{
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
                    Text {
                        anchors.fill: parent
                        text: index;
                        color: theForegroundColor;
                        font.pixelSize: parent.height * 0.8;
                        style: Text.Outline;
                        horizontalAlignment : Text.AlignHCenter
                        verticalAlignment :Text.AlignVCenter
                        styleColor: Qt.rgba( theForegroundColor.r,
                                             theForegroundColor.g,
                                             theForegroundColor.b,
                                             0.5);
                    }
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

}















