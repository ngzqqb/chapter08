import QtQuick 2.13
import sstd.listview 1.0

ListView{

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

    Component.onCompleted: {
       idListModel.resetModel()
    }

    model: VeryLargeModel{}

}




