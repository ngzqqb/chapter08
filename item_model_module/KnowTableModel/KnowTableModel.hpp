#pragma once

#include <sstd_qt_qml_quick_library.hpp>

namespace sstd{

    class KnowTableModel : public QAbstractTableModel {
        Q_OBJECT
    private:
        Q_PROPERTY(int theRowSize READ getTheRowSize WRITE setTheRowSize NOTIFY theRowSizeChanged)
    private:
        Q_PROPERTY(int theColumnSize READ getTheColumnSize WRITE setTheColumnSize NOTIFY theColumnSizeChanged)
    private:
        int thisRowSize{ 1024 };
        int thisColumnSize{ 8 };
    public:
        enum TheTableRoles{
            BackgroundRole = Qt::UserRole + 1 ,
        };
    public:
        inline int getTheRowSize() const;
        inline int getTheColumnSize() const;
        void setTheRowSize(const int &);
        void setTheColumnSize(const int &);
        Q_SIGNAL void theRowSizeChanged();
        Q_SIGNAL void theColumnSizeChanged();
    protected:
        QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
        QHash<int, QByteArray> roleNames() const override;
        int columnCount(const QModelIndex &parent = QModelIndex()) const override;
        int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    private:
        sstd_class(KnowTableModel);
    };

    inline int KnowTableModel::getTheRowSize() const{
        return thisRowSize;
    }

    inline int KnowTableModel::getTheColumnSize() const{
        return thisColumnSize;
    }

}/*namespace sstd*/
