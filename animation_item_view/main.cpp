/* animation_item_view/main.cpp */

#include <sstd_qt_qml_quick_library.hpp>
#include <optional>

int main(int argc, char ** argv) {

    sstd::QtApplication varApplication{ argc,argv };

    QQuickView varView ;
    {
        /*获得Qml文件绝对路径*/
        auto varFullFileName = sstd::autoLocalPath<QUrl>(
            QStringLiteral("appqml/animation_item_view/main.qml"));
        /*加载Qml文件*/
        varView.setSource( varFullFileName );
        /* 检查加载结果 */
        if(varView.status()!=QQuickView::Ready){
            qDebug() << varView.errors();
            return -1;
        }
    }
    varView.setResizeMode( varView.SizeRootObjectToView );
    varView.resize( 360 , 512 );
    varView.show();

    return varApplication.exec();

}

/*endl_input_of_latex_for_clanguage_lick*/
