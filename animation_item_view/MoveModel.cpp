#include "MoveModel.hpp"

namespace sstd {

    int MoveModel::rowCount(const QModelIndex &) const {
        return thisModelSize ;
    }

    static inline QColor getColor(int varIndex) {
        return QColor((varIndex) & 0x0ff,
            ((varIndex << 4) - 64) & 0x0ff,
            ((varIndex << 4) + 64) & 0x0ff);
    }

    QVariant MoveModel::data(const QModelIndex &, int ) const {
        return {};
    }

    QHash<int, QByteArray> MoveModel::roleNames() const {
        return {};
    }

    MoveModel::MoveModel() {
    }

    void MoveModel::moveOneItem(){
        this->beginMoveRows({},0,0,{},3);
        this->endMoveRows();
    }

}/*namesapce sstd*/

inline static void registerThis() {
    qmlRegisterType<sstd::MoveModel>("sstd.listview", 1, 0, "MoveModel");
}

Q_COREAPP_STARTUP_FUNCTION(registerThis)
