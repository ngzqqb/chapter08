# listview/listview.pro

TEMPLATE = app

CONFIG(debug,debug|release){
    TARGET = listview_debug
}else{
    TARGET = listview
}

SOURCES += $$PWD/main.cpp

SOURCES += $$PWD/VeryLargeModel.cpp
HEADERS += $$PWD/VeryLargeModel.hpp

SOURCES += $$PWD/GenMoreModel.cpp
HEADERS += $$PWD/GenMoreModel.hpp

SOURCES += $$PWD/EditableModel.cpp
HEADERS += $$PWD/EditableModel.hpp

include($$PWD/../../sstd_library/sstd_library.pri)
include($$PWD/../../sstd_qt_qml_quick_library/sstd_qt_qml_quick_library.pri)
include($$PWD/../../sstd_library/add_vc_debug_console.pri)

DESTDIR = $${SSTD_LIBRARY_OUTPUT_PATH}

isEmpty(QMAKE_POST_LINK){
    QMAKE_POST_LINK += $${SSTD_LIBRARY_OUTPUT_PATH}/sstd_copy_qml $${PWD} $${PWD} skip
}else{
    QMAKE_POST_LINK += $$escape_expand(\\n\\t)$${SSTD_LIBRARY_OUTPUT_PATH}/sstd_copy_qml $${PWD} $${PWD} skip
}

CONFIG(debug,debug|release){
    DEFINES += CURRENT_DEBUG_PATH=\\\"$$PWD\\\"
}else{
    QMAKE_POST_LINK += $$escape_expand(\\n\\t)$${DESTDIR}/sstd_copy_qml $${PWD}/appqml $${DESTDIR}/appqml release
    export(QMAKE_POST_LINK)
}

QMLSOURCES += $$PWD/appqml/listview/main.qml
QMLSOURCES += $$PWD/appqml/listview/ListView/PrivateBasic.qml
QMLSOURCES += $$PWD/appqml/listview/ListView/CheckCacheArea.qml
QMLSOURCES += $$PWD/appqml/listview/ListView/GenMoreData.qml

lupdate_only{
    SOURCES += $$QMLSOURCES
}

DISTFILES += $$QMLSOURCES
QML_IMPORT_PATH += $${SSTD_LIBRARY_OUTPUT_PATH}

#/*endl_input_of_latex_for_clanguage_lick*/"
