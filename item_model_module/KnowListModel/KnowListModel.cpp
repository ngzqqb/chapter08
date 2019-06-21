#include "KnowListModel.hpp"
#include <random>

namespace sstd {

    using The = KnowListModel;

    void The::setTheCount(const int & arg){
        if(arg==thisCount){
            return;
        }
        if( arg<0 ){
            qWarning() << __func__ << "less than zero : " << arg;
            return;
        }
        thisCount = arg;
        this->modelReset({});
        theCountChanged();
    }

    int The::rowCount(const QModelIndex &) const {
        return 1024;
    }

    QVariant The::data(const QModelIndex &, int role) const {
        thread_local std::mt19937 threadLocalGen{ std::random_device{}() };
        thread_local std::uniform_int_distribution threadLocalRandom{ 0 ,255 };
        if (BackGroundColorRole == role) {
            return QColor(32,
                threadLocalRandom(threadLocalGen),
                222);
        } else if (role == ForeGroundColorRole) {
            return QColor(250,
                32,
                threadLocalRandom(threadLocalGen));
        }
        return {};
    }

    QHash<int, QByteArray> The::roleNames() const {
        using T = QHash<int, QByteArray>;
        static const T globalAns = []() -> T {
            T varAns;
            varAns[BackGroundColorRole] = QByteArrayLiteral("theBackgroundColor");
            varAns[ForeGroundColorRole] = QByteArrayLiteral("theForegroundColor");
            return std::move(varAns);
        }();
        return globalAns;
    }

}/*namespace sstd*/























