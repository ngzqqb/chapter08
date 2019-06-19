
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

PrivateBasic{

    id : idRoot

    ListView{

        width: parent.width
        height: parent.height

       populate: Transition {
           NumberAnimation {
              properties: "x,y";
              duration: 1000;
           }
       }

        model: 32
        delegate: Rectangle {
            color: Qt.rgba( 1,0.2,0.2,1)
            height: 32
            width: ListView.view.width
        }

    }

}

//????????????????????????????????????

