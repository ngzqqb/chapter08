#pragma once

#include <sstd_qt_qml_quick_library.hpp>

namespace sstd {

    class TransposeProxyModel:public QTransposeProxyModel{
        Q_OBJECT
    private:
        Q_PROPERTY(QAbstractItemModel * theModel READ getTheModel WRITE setTheModel NOTIFY theModelChanged)
    public:
        inline QAbstractItemModel *getTheModel() const;
        inline void setTheModel(QAbstractItemModel *);
        Q_SIGNAL void theModelChanged();
    private:
        sstd_class(TransposeProxyModel);
    };

    inline QAbstractItemModel *TransposeProxyModel::getTheModel() const{
        return this->sourceModel();
    }

    inline void TransposeProxyModel::setTheModel(QAbstractItemModel *arg){
        if( arg == sourceModel() ){
            return;
        }
        assert( nullptr == sourceModel() );
        this->setSourceModel(arg);
        theModelChanged();
    }

}/*namespace sstd*/







