#include "VeryLargeModel.hpp"

namespace sstd {

    int VeryLargeModel::rowCount(const QModelIndex &) const {
        return 1024 * 1024;
    }

    QVariant VeryLargeModel::data(const QModelIndex &index, int role) const {
        if (index.isValid()) {
            const auto varIndex = index.row();
            if (varIndex < rowCount()) {
                if (role == BackGroundColorRole) {
                    return QColor((varIndex) & 255,
                        ((varIndex << 4) - 64) & 255,
                        ((varIndex << 4) + 64) & 255);
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















