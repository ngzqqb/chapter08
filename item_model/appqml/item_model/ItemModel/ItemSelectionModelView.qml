import QtQuick 2.13
import QtQuick.Controls 2.13

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
    }

   ScrollView{
       anchors.fill: parent
       ListView{
           model: idModel
           id : idListView
           onCurrentIndexChanged:{
               console.log("xxxx")
           }
           delegate: Rectangle{
               width: parent.width
               height: 32
               border.color: "black"
               border.width: 3 ;
               Text {
                   anchors.centerIn: parent
                   text: index
               }
               MouseArea{
                   anchors.fill: parent
                   onClicked: {
                       idListView.currentIndex = index;
                   }
               }
           }
       }
   }

}
