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

        id : idColumnLayout
        anchors.fill: parent

        Label{
            text: idListView.count
        }

        ListView{
            id : idListView
            clip: true
            Layout.fillHeight: true
            Layout.fillWidth: true

            model: idModel
            delegate: Rectangle {
                color: theBackgroundColor
                height: 32
                width: ListView.view.width
            }

        }

    }

    BusyIndicator{
        z : idColumnLayout.z + 1
        id : idBusyIndicator
        visible: idModel.fecthState === GenMoreModel.Fetching
        running: idModel.fecthState === GenMoreModel.Fetching
        anchors.bottom: idColumnLayout.bottom
        anchors.horizontalCenter: idColumnLayout.horizontalCenter
        background: Item{}
    }

}
