import QtQuick 2.13
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

import sstd.listview 1.0

Page {

    header: ToolBar{
        RowLayout {
            anchors.fill: parent
            ToolButton{
                Layout.fillWidth: true
                text: qsTr("增加一个元素")
                onClicked: {
                    idListModel.insertOneToFirst();
                }
            }
            ToolButton{
                Layout.fillWidth: true
                text: qsTr("重新加载模型")
                onClicked: {
                    idListModel.modelReset();
                }
            }
            ToolButton{
                Layout.fillWidth: true
                text: qsTr("删除一个元素")
                onClicked: {
                    idListModel.popOneFromFirst();
                }
            }
        }
    }

    ListView{
        clip: true;
        anchors.fill: parent;

        delegate: Rectangle{
            width: parent.width ;
            height: 32 ;
            property color randColor: "black" ;
            Component.onCompleted: {
                var varView = ListView.view ;
                randColor = (varView.count & 1)?
                            Qt.rgba(0.7 ,
                                    0.6-0.5*Math.random(),
                                    0.0,
                                    1):
                            Qt.rgba(0.7-0.5*Math.random(),
                                    0.6 ,
                                    0.0,
                                    1);
            }
            gradient: Gradient {
                GradientStop {
                    position: 0.0;
                    color: randColor
                }
                GradientStop {
                    position: 1.0;
                    color: Qt.lighter( randColor )
                }
            }
        }

        populate : Transition {
            NumberAnimation {
                properties: "x,y";
            }
        }

        model: AddRemoveModel{
            id : idListModel;
        }

        displaced: Transition {
            NumberAnimation { properties: "x,y"; duration: 1000 }
        }

        Component.onCompleted: {
            for(var varI = 0;varI < 8 ; ++varI){
                idListModel.insertOneToFirst();
            }
            idListModel.modelReset();
        }

    }

}

