#pragma once

#include <sstd_qt_qml_quick_library.hpp>

namespace sstd {

    class ItemSelectionModel:public QItemSelectionModel{
        Q_OBJECT
    public:
        Q_INVOKABLE void selectRowRange(const QModelIndex&,const QModelIndex &, QItemSelectionModel::SelectionFlags);
    private:
        sstd_class(ItemSelectionModel);
    };

}/*namespace sstd*/



