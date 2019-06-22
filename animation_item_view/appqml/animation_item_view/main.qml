/* appqml/animation_item_view/main.qml */
import QtQuick 2.13
import QtQuick.Controls 2.13

/*begin:import*/
import theqml_the_debug.qml_files_dir_loader_module 1.0
import theqml_the_debug.sstd.styled.app 1.0
/*end:import*/

StyledApplicationWindow {

    width: 360
    height: 512

    header: TabBar{
        id : idTabBar
        anchors.left: parent.left;
        anchors.right: parent.right;

        TabButton {
            text: qsTr("导航");
            onClicked: {
                if(idFlipable.side === Flipable.Front){
                    return;
                }
                idFlipable.flipped = false;
            }
        }
        TabButton {
            id : idLoadLoaderButton
            text: qsTr("组件");
            onClicked: {
                if( idFlipable.side === Flipable.Back ){
                    return;
                }
                idFlipable.flipped = true;
            }
        }
    }


    Flipable {
        id : idFlipable

        anchors.fill: parent;
        property bool flipped: false ;

        front: Item{
            anchors.fill: parent ;
            ListView {
                id : idListView
                width: parent.width ;
                height: parent.height;
                focus: true;

                ScrollBar.vertical: ScrollBar {
                }

                QmlFilesModel{
                    id : idTheModel ;
                    qmlFilesDir : "QmlFiles";
                }

                Component.onCompleted: {
                    Qt.callLater( function(){
                        idTheModel.modelReset();/*there is some bug ???*/
                    } )
                }

                model: idTheModel ;
                delegate: ItemDelegate{
                    width: parent.width;
                    text: fileName
                    onClicked: {
                        if( idFlipable.flipped ){
                            return;
                        }
                        idLoader.source = ""/*forece delete last one ....*/;
                        idLoader.source = filePath ;
                        idFlipable.flipped = true  ;
                        idLoadLoaderButton.toggle();
                    }
                }

                populate: Transition {
                    id : idTransition
                    NumberAnimation {
                        properties: "x,y";
                        duration: 800 ;
                    }
                }
            }
        }

        back: Loader{
            id : idLoader
            anchors.fill: parent;
        }

        states: State {
            name: "back"
            PropertyChanges {
                target: idRotation;
                angle: 180;
            }
            when: idFlipable.flipped
        }

        transitions: Transition {
            NumberAnimation {
                target: idRotation;
                property: "angle";
                duration: 800
            }
        }

        transform: Rotation {
            id: idRotation
            origin.x: idFlipable.width/2
            origin.y: idFlipable.height/2
            axis.x: 0;
            axis.y: 1;
            axis.z: 0
            angle: 0 ;
        }

    }

    /*begin:debug*/
    Timer{
        interval: 1500;
        running: true;
        repeat: true
        onTriggered: {
            GlobalAppData.isDark = !GlobalAppData.isDark;
        }
    }
    /*end:debug*/

}

/*endl_input_of_latex_for_clanguage_lick*/
/*begin:debug*/
/*end:debug*/
