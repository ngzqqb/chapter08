#pragma once

#include <sstd_qt_qml_quick_library.hpp>

namespace sstd {

    class SortFilterProxyModel :public QSortFilterProxyModel {
        Q_OBJECT
    private:
        Q_PROPERTY(QJSValue lessThanFunction READ getLessThanFunction WRITE setLessThanFunction NOTIFY lessThanFunctionChanged)
    private:
        Q_PROPERTY(QAbstractItemModel * theModel READ getTheModel WRITE setTheModel NOTIFY theModelChanged)
    public:
        inline QJSValue getLessThanFunction() const;
        void setLessThanFunction(const QJSValue &);
        Q_INVOKABLE inline void clearLessThanFunction();
        Q_SIGNAL void lessThanFunctionChanged();
    public:
        Q_INVOKABLE void sort(int);
    public:
        inline QAbstractItemModel *getTheModel() const;
        inline void setTheModel(QAbstractItemModel *);
        Q_SIGNAL void theModelChanged();
    protected:
        bool lessThan(const QModelIndex &source_left, const QModelIndex &source_right) const override;
    private:
        std::optional< QJSValue > thisLessThanFunction;
        using Super = QSortFilterProxyModel;
    private:
        sstd_class(SortFilterProxyModel);
    };

    inline void SortFilterProxyModel::clearLessThanFunction() {
        thisLessThanFunction.reset();
    }

    inline QAbstractItemModel *SortFilterProxyModel::getTheModel() const{
        return this->sourceModel();
    }

    inline void SortFilterProxyModel::setTheModel(QAbstractItemModel *arg){
        if( arg == sourceModel() ){
            return;
        }
        assert( nullptr == sourceModel() );
        this->setSourceModel(arg);
        theModelChanged();
    }

    inline QJSValue SortFilterProxyModel::getLessThanFunction() const {
        if (thisLessThanFunction) {
            return *thisLessThanFunction;
        }
        return {};
    }

}/*namespace sstd*/
