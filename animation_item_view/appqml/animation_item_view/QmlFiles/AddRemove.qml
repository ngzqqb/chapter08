import QtQuick 2.13
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

import sstd.listview 1.0

Page {

    header: TabBar{
        TabButton{
            text: qsTr("增加一个元素")
            onClicked: {
                idListModel.insertOneToFirst();
            }
        }
        TabButton{
            text: qsTr("重新加载模型")
            onClicked: {
                idListModel.modelReset();
            }
        }
        TabButton{
            text: qsTr("删除一个元素")
            onClicked: {
                idListModel.popOneFromFirst();
            }
        }
    }

    ListView{
        clip: true;
        anchors.fill: parent;

        delegate: Rectangle{
            width: parent.width ;
            height: 32 ;
            property color randColor: Qt.rgba(0.5+0.5*Math.random(),
                                              0.5+0.5*Math.random(),
                                              0.0,1)
            gradient: Gradient {
                GradientStop {
                    position: 0.0;
                    color: randColor
                }
                GradientStop {
                    position: 1.0;
                    color: "blue"
                }
            }
        }

        add : Transition {
               NumberAnimation {
                   properties: "x,y";
                   from: 100;
                   duration: 1000
               }
        }

        remove : Transition {
            ParallelAnimation {
                NumberAnimation {
                    property: "opacity";
                    to: 0;
                    duration: 1000
                }
                NumberAnimation {
                    properties: "x,y";
                    to: 100;
                    duration: 1000
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

        Component.onCompleted: {
            idListModel.modelReset();
        }

    }

}











