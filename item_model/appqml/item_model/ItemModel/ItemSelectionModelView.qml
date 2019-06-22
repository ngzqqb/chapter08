import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQml.Models 2.13

/*begin:import*/
import theqml_the_debug.item_model_module 1.0
/*end:import*/

PrivateBasic{

    KnowListModel{
        id : idModel
        theCount: 64
    }

    ItemSelectionModel{
        model: idModel
        id : idSelectModel
    }

    ScrollView{
        anchors.fill: parent ;
        ListView{
            id : idListView
            highlightRangeMode : ListView.StrictlyEnforceRange

            onCurrentIndexChanged:{
                idSelectModel.setCurrentIndex( idModel.index(currentIndex,0) ,
                                              ItemSelectionModel.SelectCurrent)
            }

            delegate  : MouseArea{
                width: parent.width
                height: 32

                onClicked: {
                    idListView.currentIndex = index;
                }

                Rectangle{
                    id : idBackGround;
                    anchors.fill: parent;
                    property bool isSelect :  checkIsSelect() ;

                    function checkIsSelect(){
                        return true;
                    }

                    Connections{
                        target: idSelectModel
                        onSelectionChanged:{
                            idBackGround.isSelect = idBackGround.checkIsSelect();
                        }
                    }

                    Rectangle{
                        width: parent.width
                        height: parent.height ;
                        color: "transparent"
                        border.color: "black"
                        border.width: 3 ;
                    }

                }
            }
            model: idModel
        }

    }

}
