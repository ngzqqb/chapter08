#include <sstd_qt_qml_quick_library.hpp>

namespace sstd {

    class GenMoreModel : public QAbstractListModel {
        Q_OBJECT
    private:
        Q_PROPERTY(qint32 modelStamp READ getModelStamp NOTIFY modelStampChanged FINAL)
    public:
        enum AllRoles : int {
            BackGroundColorRole = Qt::UserRole + 1,
        };
    public:
        inline qint32 getModelStamp() const;
        void setModelStamp(qint32);
        void nextModelStamp();
        Q_SIGNAL void modelStampChanged();
    public:
        GenMoreModel();
    protected:
        int rowCount(const QModelIndex &parent = QModelIndex()) const override;
        QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
        QHash<int, QByteArray> roleNames() const override;
        bool canFetchMore(const QModelIndex &parent) const override;
        void fetchMore(const QModelIndex &parent);
    private:
        int thisModelSize{ 128 };
        qint32 thisModelStamp{ 0 };
    private:
        sstd_class(GenMoreModel);
    };

    qint32 GenMoreModel::getModelStamp() const {
        return thisModelStamp;
    }


}/*namespace sstd*/
