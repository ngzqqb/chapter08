#include "GenMoreModel.hpp"

namespace sstd {

    int GenMoreModel::rowCount(const QModelIndex &) const {
        return thisModelSize;
    }

    void GenMoreModel::setFecthState(FetchState arg) {
        if (arg == thisFetchState) {
            return;
        }
        thisFetchState = arg;
        fecthStateChanged();
    }

    QVariant GenMoreModel::data(const QModelIndex &index, int role) const {
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

    QHash<int, QByteArray> GenMoreModel::roleNames() const {
        using T = QHash<int, QByteArray>;
        static const T globalAns = []() -> T {
            T varAns;
            varAns[BackGroundColorRole] = QByteArrayLiteral("theBackgroundColor");
            return std::move(varAns);
        }();
        return globalAns;
    }

    GenMoreModel::GenMoreModel() {
    }

    bool GenMoreModel::canFetchMore(const QModelIndex &parent) const {
        if (parent.isValid()) {
            return parent.row() == (thisModelSize - 1);
        }
        return true;
    }

    void GenMoreModel::fetchMore(const QModelIndex &) {
        if (this->getFecthState() == FetchState::Fetching) {
            return;
        }
        this->setFecthState(FetchState::Fetching);
        QTimer::singleShot(1500, this, [this]() {
            constexpr int const varFakeSize = 8;
            this->beginInsertRows(QModelIndex(), thisModelSize, thisModelSize + varFakeSize - 1);
            thisModelSize += varFakeSize;
            this->endInsertRows();
            QTimer::singleShot(10, this, [this]() {/*过滤过于密集的事件*/
                this->setFecthState(FetchState::Fectched);
            });
        });
    }

}/*namesapce sstd*/

inline static void registerThis() {
    qmlRegisterType<sstd::GenMoreModel>("sstd.listview", 1, 0, "GenMoreModel");
}

Q_COREAPP_STARTUP_FUNCTION(registerThis)
