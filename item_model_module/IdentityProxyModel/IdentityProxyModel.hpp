#pragma once

#include <sstd_qt_qml_quick_library.hpp>

namespace sstd {

    class IdentityProxyModel:public QIdentityProxyModel{
        Q_OBJECT
    private:
        Q_PROPERTY(QAbstractItemModel * theModel READ getTheModel WRITE setTheModel NOTIFY theModelChanged)
    private:
        Q_PROPERTY(QString theAttachedText READ getTheAttachedText WRITE setTheAttachedText NOTIFY theAttachedTextChanged)
    public:
        enum AttachedRoles {
            AttachedTextRole = Qt::UserRole + 1024 ,
        };
    public:
        inline QString getTheAttachedText() const;
        void setTheAttachedText(const QString &);
        Q_SIGNAL void theAttachedTextChanged();
    public:
        inline QAbstractItemModel *getTheModel() const;
        inline void setTheModel(QAbstractItemModel *);
        Q_SIGNAL void theModelChanged();
    private:
        QString thisAttachedText;
        using Super = QIdentityProxyModel;
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
        assert( nullptr == sourceModel() );
        this->setSourceModel(arg);
        theModelChanged();
    }

    inline QString IdentityProxyModel::getTheAttachedText() const{
        return thisAttachedText;
    }

}/*namespace sstd*/

