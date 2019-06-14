#include "GenMoreModel.hpp"

namespace sstd {

    int GenMoreModel::rowCount(const QModelIndex &) const {
        return thisModelSize;
    }

    void GenMoreModel::setModelStamp(qint32 arg) {
        if (arg == thisModelStamp) {
            return;
        }
        thisModelStamp = arg;
        modelStampChanged();
    }

    void GenMoreModel::nextModelStamp() {
        if (thisModelStamp == std::numeric_limits<qint32>::max()) {
            this->setModelStamp(0);
        } else if (thisModelStamp < 0) {
            this->setModelStamp(0);
        } else {
            this->setModelStamp(thisModelStamp + 1);
        }
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
        qDebug() << "jxxxxxxxxx";
    }

}/*namesapce sstd*/

inline static void registerThis() {
    qmlRegisterType<sstd::GenMoreModel>("sstd.listview", 1, 0, "GenMoreModel");
}

Q_COREAPP_STARTUP_FUNCTION(registerThis)















