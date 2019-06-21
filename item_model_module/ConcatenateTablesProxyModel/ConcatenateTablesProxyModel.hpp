#pragma once

#include <sstd_qt_qml_quick_library.hpp>

namespace sstd {

    class ConcatenateTablesProxyModel:public QConcatenateTablesProxyModel{
        Q_OBJECT
    public:
        Q_INVOKABLE void addSourceModel(QAbstractItemModel *sourceModel);
        QHash<int, QByteArray> roleNames() const override ;
    private:
        using Super = QConcatenateTablesProxyModel;
        QHash<int, QByteArray> thisRoleNames;
    private:
        sstd_class(ConcatenateTablesProxyModel);
    };

}/*namespace sstd*/
