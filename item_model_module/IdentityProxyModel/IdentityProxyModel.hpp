#pragma once

#include <sstd_qt_qml_quick_library.hpp>

namespace sstd {

    class IdentityProxyModel:public QIdentityProxyModel{
        Q_OBJECT
    private:
        Q_PROPERTY(QAbstractItemModel * theModel READ getTheModel WRITE setTheModel NOTIFY theModelChanged)
    public:
        inline QAbstractItemModel *getTheModel() const;
        inline void setTheModel(QAbstractItemModel *);
        Q_SIGNAL void theModelChanged();
    protected:
        QHash<int, QByteArray> roleNames() const override;
        QVariant data(const QModelIndex &proxyIndex, int role = Qt::DisplayRole) const override;
    private:
        sstd_class(IdentityProxyModel);
    };

    inline QAbstractItemModel *IdentityProxyModel::getTheModel() const{
        return this->sourceModel();
    }

    inline void IdentityProxyModel::setTheModel(QAbstractItemModel *arg){
        if( arg == sourceModel() ){
            return;
        }
        this->setSourceModel(arg);
        theModelChanged();
    }

}/*namespace sstd*/

