#pragma once

#include <sstd_library.hpp>
#include <QtCore/qitemselectionmodel.h>

namespace sstd {

    class ItemSelectionModel:public QItemSelectionModel{
        Q_OBJECT
    public:
        Q_INVOKABLE void selectRangePair(const QModelIndex&,const QModelIndex &, QItemSelectionModel::SelectionFlags);
    private:
        sstd_class(ItemSelectionModel);
    };

}/*namespace sstd*/



