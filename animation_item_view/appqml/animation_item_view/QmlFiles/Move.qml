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
                text: qsTr("重新加载模型")
                onClicked: {
                    idListModel.modelReset();
                }
            }
            ToolButton{
                Layout.fillWidth: true
                text: qsTr("移动一个元素")
                onClicked: {
                    idListModel.moveOneItem();
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
                randColor = (index & 1)?
                            Qt.rgba(0.9 ,
                                    0.3*Math.random(),
                                    0.0,
                                    1):
                            (index & 3)?
                                Qt.rgba(0.0 ,
                                        0.3*Math.random(),
                                        0.9,
                                        1):
                                Qt.rgba(0.3*Math.random(),
                                        0.9 ,
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

        move : Transition {
            id : idMoveTransition
            NumberAnimation{
                id : idMoveAnimation
                properties: "x,y";
                duration: 1000
            }
            onRunningChanged: {
                if(running){
                    ViewTransition.item.z = 100 ;
                }else{
                    ViewTransition.item.z = 1   ;
                }
            }
        }

        model: MoveModel{
            id : idListModel;
        }

        Component.onCompleted: {
            idListModel.modelReset();
        }

    }

}
