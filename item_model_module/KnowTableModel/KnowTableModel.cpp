#include "KnowTableModel.hpp"


namespace sstd{

    using The = KnowTableModel;

    void The::setTheRowSize(const int & arg){
        if( arg == thisRowSize ){
            return;
        }
        if( arg < 0){
            qWarning() << __func__ << "less than zero : "<< arg;
            return;
        }
        thisRowSize = arg;
        theRowSizeChanged();
    }

    void The::setTheColumnSize(const int & arg){
        if( arg == thisColumnSize ){
            return;
        }
        if( arg < 0){
            qWarning() << __func__ << "less than zero : "<< arg;
            return;
        }
        thisColumnSize = arg;
        theColumnSizeChanged();
    }

    QVariant The::data(const QModelIndex & argIndex, int role ) const {
        if( role == BackgroundRole ){
            if( argIndex.row() &1 ){
                return QColor( 255 , 64, 64 );
            }else{
                return QColor( 64 , 255, 64 );
            }
        }
        return {};
    }

    QHash<int, QByteArray> The::roleNames() const {
        using T = QHash<int, QByteArray>;
        static const auto globalAns = []() ->T {
            T varAns;
            varAns[BackgroundRole] = QByteArrayLiteral("theBackgroundColor");
            return std::move(varAns);
        }();
        return globalAns;
    }

    int The::columnCount(const QModelIndex & ) const {
        return thisColumnSize;
    }

    int The::rowCount(const QModelIndex & ) const {
        return thisRowSize;
    }

}/*namespace sstd*/



