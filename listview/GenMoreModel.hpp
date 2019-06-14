#include <sstd_qt_qml_quick_library.hpp>

namespace sstd {

    class GenMoreModel : public QAbstractListModel {
        Q_OBJECT
    public:
        enum FetchState{
            Fetching,
            Fectched,
        };
        Q_ENUM(FetchState)
    private:
        Q_PROPERTY(FetchState fecthState READ getFecthState NOTIFY fecthStateChanged FINAL)
    public:
        enum AllRoles : int {
            BackGroundColorRole = Qt::UserRole + 1,
        };
    public:
        inline FetchState getFecthState() const;
        void setFecthState(FetchState);
        Q_SIGNAL void fecthStateChanged();
    public:
        GenMoreModel();
    protected:
        int rowCount(const QModelIndex &parent = QModelIndex()) const override;
        QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
        QHash<int, QByteArray> roleNames() const override;
        bool canFetchMore(const QModelIndex &parent) const override;
        void fetchMore(const QModelIndex &parent) override;
    private:
        int thisModelSize{ 32 };
        FetchState thisFetchState{ FetchState::Fectched };
    private:
        sstd_class(GenMoreModel);
    };

    GenMoreModel::FetchState GenMoreModel::getFecthState() const {
        return thisFetchState;
    }


}/*namespace sstd*/
