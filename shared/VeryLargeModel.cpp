#include "VeryLargeModel.hpp"

namespace sstd {

    int VeryLargeModel::rowCount(const QModelIndex &) const {
        return 1024 * 1024;
    }

    static inline QColor getColor(int varIndex) {
        return QColor((varIndex) & 0x0ff,
            ((varIndex << 4) - 64) & 0x0ff,
            ((varIndex << 4) + 64) & 0x0ff);
    }

    QVariant VeryLargeModel::data(const QModelIndex &index, int role) const {
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

    QHash<int, QByteArray> VeryLargeModel::roleNames() const {
        using T = QHash<int, QByteArray>;
        static const T globalAns = []() -> T {
            T varAns;
            varAns[BackGroundColorRole] = QByteArrayLiteral("theBackgroundColor");
            varAns[ForeGroundColorRole] = QByteArrayLiteral("theForegroundColor");
            return std::move(varAns);
        }();
        return globalAns;
    }

    VeryLargeModel::VeryLargeModel() {
    }


}/*namesapce sstd*/

inline static void registerThis() {
    qmlRegisterType<sstd::VeryLargeModel>("sstd.listview", 1, 0, "VeryLargeModel");
}

Q_COREAPP_STARTUP_FUNCTION(registerThis)















