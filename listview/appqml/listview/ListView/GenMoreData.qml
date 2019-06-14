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

            BusyIndicator{
                id : idBusyIndicator
                visible: idModel.fecthState === GenMoreModel.Fetching
                running: idModel.fecthState === GenMoreModel.Fetching
                anchors.bottom: idListView.bottom
                anchors.horizontalCenter: idListView.horizontalCenter
            }

        }
    }

}















