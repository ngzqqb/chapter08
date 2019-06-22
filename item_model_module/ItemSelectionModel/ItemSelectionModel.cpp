#include "ItemSelectionModel.hpp"

namespace sstd {

    using The = ItemSelectionModel;

    void The::selectRowRange(const QModelIndex& arg0,
        const QModelIndex & arg1,
        QItemSelectionModel::SelectionFlags arg2) {
        this->select({ arg0,arg1 }, arg2);
    }

}

