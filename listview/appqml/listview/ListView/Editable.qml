import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import sstd.listview 1.0

PrivateBasic{

    id : idRoot
    property int liveItemCount: 0

    EditableModel {
        id : idModel
    }

    ColumnLayout{

        anchors.fill: parent

        ScrollView{
            Layout.fillHeight: true
            Layout.fillWidth: true
            ListView{

                clip: true
                anchors.fill: parent

                model: idModel
                delegate: Rectangle {
                    color: theBackgroundColor
                    height: idText.height
                    width: ListView.view.width

                    TextField {
                        id: idText
                        readOnly: false
                        width: parent.width
                        text: theShowText;
                        onEditingFinished: {
                            if( theShowText === text ){
                                return;
                            }
                            theShowText = text ;
                            text = Qt.binding( function(){ return model.theShowText ; } )
                        }
                    }

                }

            }

        }
    }

}















