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

    QVariant AddRemoveModel::data(const QModelIndex &index, int role) const {
        if (index.isValid()) {
            const auto varIndex = index.row();
            if (varIndex < rowCount()) {
                if (role == BackGroundColorRole) {
                    return getColor(varIndex);
                } else if (role == ForeGroundColorRole) {
                    const auto varColor = getColor(varIndex).toRgb();
                    int varH = 0;
                    int varS = 0;
                    int varV = 0;
                    varColor.getHsv(&varH, &varS, &varV);
                    auto varAH = varH + 100;
                    auto varAV = varV + 45;
                    return QColor::fromHsv((varAH > 359) ? (varAH - 359) : varAH,
                        varS,
                        (varAV > 255) ? (varAV - 65 ) : varAV);
                }
            }
        }
        return {};
    }

    QHash<int, QByteArray> AddRemoveModel::roleNames() const {
        using T = QHash<int, QByteArray>;
        static const T globalAns = []() -> T {
            T varAns;
            varAns[BackGroundColorRole] = QByteArrayLiteral("theBackgroundColor");
            varAns[ForeGroundColorRole] = QByteArrayLiteral("theForegroundColor");
            return std::move(varAns);
        }();
        return globalAns;
    }

    AddRemoveModel::AddRemoveModel() {
    }

    void AddRemoveModel::insertOneToFirst(){
        this->beginInsertRows({},0,1);
        ++thisModelSize ;
        this->endInsertRows();
    }

    void AddRemoveModel::popOneFromFirst(){
        if( thisModelSize>1 ){
            this->beginRemoveRows({},0,1);
            --thisModelSize;
            this->endRemoveRows();
        }
    }

}/*namesapce sstd*/

inline static void registerThis() {
    qmlRegisterType<sstd::AddRemoveModel>("sstd.listview", 1, 0, "AddRemoveModel");
}

Q_COREAPP_STARTUP_FUNCTION(registerThis)















