#include "AddRemoveModel.hpp"

namespace sstd {

    int AddRemoveModel::rowCount(const QModelIndex &) const {
        return thisModelSize ;
    }

    static inline QColor getColor(int varIndex) {
        return QColor((varIndex) & 0x0ff,
            ((varIndex << 4) - 64) & 0x0ff,
            ((varIndex << 4) + 64) & 0x0ff);
    }

    QVariant AddRemoveModel::data(const QModelIndex &, int ) const {
        return {};
    }

    QHash<int, QByteArray> AddRemoveModel::roleNames() const {
        return {};
    }

    AddRemoveModel::AddRemoveModel() {
    }

    void AddRemoveModel::insertOneToFirst(){
        this->beginInsertRows({},0,0);
        ++thisModelSize ;
        this->endInsertRows();
    }

    void AddRemoveModel::popOneFromFirst(){
        if( thisModelSize>0 ){
            this->beginRemoveRows({},0,0);
            --thisModelSize;
            this->endRemoveRows();
        }
    }

}/*namesapce sstd*/

inline static void registerThis() {
    qmlRegisterType<sstd::AddRemoveModel>("sstd.listview", 1, 0, "AddRemoveModel");
}

Q_COREAPP_STARTUP_FUNCTION(registerThis)

