/* appqml/animation_item_view/main.qml */
import QtQuick 2.13
import QtQuick.Controls 2.13


/*begin:import*/
import theqml_the_debug.qml_files_dir_loader_module 1.0
/*end:import*/

Item{

    TabBar{
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

        anchors.right: parent.right;
        anchors.left: parent.left
        anchors.top:  idTabBar.bottom;
        anchors.bottom: parent.bottom

        property bool flipped: false ;

        front: Item{
            anchors.fill: parent ;
            ListView {

                width: parent.width ;
                height: parent.height;

                focus: true;

                QmlFilesModel{
                    id : idTheModel
                    qmlFilesDir : "QmlFiles";
                }

                model: idTheModel;
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
                        properties: "y";
                        duration: idTransition.ViewTransition.index * 1000 ;
                        to : 120
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

}

/*endl_input_of_latex_for_clanguage_lick*/
/*begin:debug*/
/*end:debug*/

// There is still a bug , I am finding a way to solve it .


