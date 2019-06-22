#include "ConcatenateTablesProxyModel.hpp"

void sstd::ConcatenateTablesProxyModel::addSourceModel(QAbstractItemModel *sourceModel){
    if(thisRoleNames.empty()){
        thisRoleNames = sourceModel->roleNames();
    }
    Super::addSourceModel(sourceModel);
}

QHash<int, QByteArray> sstd::ConcatenateTablesProxyModel::roleNames() const {
    return thisRoleNames;
}
