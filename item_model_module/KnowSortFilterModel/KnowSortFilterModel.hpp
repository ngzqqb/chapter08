#pragma once

#include <sstd_qt_qml_quick_library.hpp>

namespace sstd {

    class KnowSortFilterModel: public QAbstractTableModel {
        Q_OBJECT
    public:
        enum TheRoles{
            Key1 = Qt::UserRole + 1,
            Key2,
            Key3
        };
        Q_ENUM(TheRoles)
    protected:
        int columnCount(const QModelIndex &parent = QModelIndex()) const override;
        int rowCount(const QModelIndex &parent = QModelIndex()) const override;
        QHash<int, QByteArray> roleNames() const override;
        QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    private:
        sstd_class(KnowSortFilterModel);
    };

}/*namespace sstd*/
