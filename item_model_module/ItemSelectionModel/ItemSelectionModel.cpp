#include "ItemSelectionModel.hpp"

namespace sstd {

    using The = ItemSelectionModel;

    void The::selectRangePair(const QModelIndex& arg0,
        const QModelIndex & arg1,
        QItemSelectionModel::SelectionFlags arg2) {
        this->select(QItemSelection( arg0,arg1 ), arg2);
    }

}

