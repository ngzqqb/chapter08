import QtQuick 2.13
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

import sstd.listview 1.0

ColumnLayout{

    Button{
        Layout.fillWidth: true
        text: qsTr("重新加载模型")
        onClicked: {
            idListModel.modelReset();
        }
    }

    ListView{
        clip: true;
        Layout.fillWidth: true
        Layout.fillHeight: true

        delegate: Rectangle{
            width: parent.width ;
            height: 32 ;
            color: theBackgroundColor;
        }

        populate : Transition {
            NumberAnimation {
                properties: "x,y";
            }
        }

        model: VeryLargeModel{
            id : idListModel;
        }

        Component.onCompleted: {
            idListModel.modelReset();
        }

    }

}

