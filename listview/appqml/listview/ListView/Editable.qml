import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import sstd.listview 1.0

PrivateBasic{

    id : idRoot

    EditableModel {
        id : idModel
    }

    RowLayout{

        anchors.fill: parent

       ScrollView{
           id : idLeft
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
                           theShowText = text ;
                       }
                   }
               }
           }

           ScrollBar.vertical.onPositionChanged :{
               idRoot.updateScrollBarPosition(idLeft.ScrollBar.vertical.position,
                                              false/*set right*/ );
           }

       }

        ScrollView{
            id : idRight
            Layout.fillHeight: true
            Layout.fillWidth: true

            ListView{

                clip: true
                anchors.fill: parent

                model: idModel

                delegate: Rectangle {
                    color: theBackgroundColor
                    height: idText1.height
                    width: ListView.view.width

                    TextField {
                        id : idText1
                        readOnly: true
                        width: parent.width
                        text: theShowText;
                    }
                }

            }

            ScrollBar.vertical.onPositionChanged :{
                idRoot.updateScrollBarPosition(idRight.ScrollBar.vertical.position,
                                               true/*set left*/ );
            }

        }

    }

    function updateScrollBarPosition(argValue,argLeft){
        var varLeftVertical = idLeft.ScrollBar.vertical;
        var varRightVertical = idRight.ScrollBar.vertical;
        var varHeight = varRightVertical.height ;
        /*begin:debug*/
        console.log( "updateScrollBarPosition : " , varHeight ) ;
        /*end:debug*/
        if( varHeight * Math.abs( varLeftVertical.position - varRightVertical.position ) < 0.1 ){
            return;
        }
        if(argLeft){
            varLeftVertical.position = argValue;
        }else{
            varRightVertical.position = argValue;
        }
    }

}















