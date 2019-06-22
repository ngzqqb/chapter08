# item_model_module/item_model_module.pro

TEMPLATE = lib
CONFIG += plugin
TARGET = $$qtLibraryTarget(item_model_module)

SOURCES += $$PWD/the_moudle.cpp
HEADERS += $$PWD/the_moudle.hpp

SOURCES += $$PWD/Empty.cpp
HEADERS += $$PWD/Empty.hpp

SOURCES += $$PWD/ConcatenateTablesProxyModel/ConcatenateTablesProxyModel.cpp
HEADERS += $$PWD/ConcatenateTablesProxyModel/ConcatenateTablesProxyModel.hpp

SOURCES += $$PWD/TransposeProxyModel/TransposeProxyModel.cpp
HEADERS += $$PWD/TransposeProxyModel/TransposeProxyModel.hpp

SOURCES += $$PWD/SortFilterProxyModel/SortFilterProxyModel.cpp
HEADERS += $$PWD/SortFilterProxyModel/SortFilterProxyModel.hpp

SOURCES += $$PWD/IdentityProxyModel/IdentityProxyModel.cpp
HEADERS += $$PWD/IdentityProxyModel/IdentityProxyModel.hpp

SOURCES += $$PWD/KnowListModel/KnowListModel.cpp
HEADERS += $$PWD/KnowListModel/KnowListModel.hpp

SOURCES += $$PWD/KnowTableModel/KnowTableModel.cpp
HEADERS += $$PWD/KnowTableModel/KnowTableModel.hpp

SOURCES += $$PWD/KnowSortFilterModel/KnowSortFilterModel.cpp
HEADERS += $$PWD/KnowSortFilterModel/KnowSortFilterModel.hpp

SOURCES += $$PWD/ItemSelectionModel/ItemSelectionModel.cpp
HEADERS += $$PWD/ItemSelectionModel/ItemSelectionModel.hpp

include($$PWD/../../sstd_library/sstd_library.pri)
include($$PWD/../../sstd_qt_qml_quick_library/sstd_qt_qml_quick_library.pri)

isEmpty(QMAKE_POST_LINK){
    QMAKE_POST_LINK += $${SSTD_LIBRARY_OUTPUT_PATH}/sstd_copy_qml $${PWD} $${PWD} skip
}else{
    QMAKE_POST_LINK += $$escape_expand(\\n\\t)$${SSTD_LIBRARY_OUTPUT_PATH}/sstd_copy_qml $${PWD} $${PWD} skip
}
mkpath($${SSTD_LIBRARY_OUTPUT_PATH}/theqml_the_debug/item_model_module)
CONFIG(debug,debug|release) {
    DESTDIR = $${SSTD_LIBRARY_OUTPUT_PATH}/theqml_the_debug/item_model_module
    QMAKE_POST_LINK += $$escape_expand(\\n\\t)$${SSTD_LIBRARY_OUTPUT_PATH}/sstd_copy_qml $${PWD}/theqml_the_debug $${SSTD_LIBRARY_OUTPUT_PATH}/theqml_the_debug debug
}else{
    DESTDIR = $${SSTD_LIBRARY_OUTPUT_PATH}/theqml/item_model_module
    QMAKE_POST_LINK += $$escape_expand(\\n\\t)$${SSTD_LIBRARY_OUTPUT_PATH}/sstd_copy_qml $${PWD}/theqml_the_debug $${SSTD_LIBRARY_OUTPUT_PATH}/theqml release
    QMAKE_POST_LINK += $$escape_expand(\\n\\t)$$[QT_INSTALL_BINS]/qmlplugindump -notrelocatable theqml.item_model_module 1.0 $${SSTD_LIBRARY_OUTPUT_PATH} > $${SSTD_LIBRARY_OUTPUT_PATH}/theqml_the_debug/item_model_module/plugins.qmltypes
}
export(QMAKE_POST_LINK)

DISTFILES += $$PWD/theqml_the_debug/item_model_module/qmldir

#/*endl_input_of_latex_for_clanguage_lick*/
