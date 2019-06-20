
#include <sstd_qt_qml_quick_library.hpp>

namespace sstd {

    class AddRemoveModel : public QAbstractListModel {
        Q_OBJECT
    public:
        enum AllRoles : int {
            BackGroundColorRole = Qt::UserRole + 1,
            ForeGroundColorRole,
        };
    public:
        AddRemoveModel();
    public:
        Q_INVOKABLE void insertOneToFirst();
        Q_INVOKABLE void popOneFromFirst();
    protected:
        int rowCount(const QModelIndex &parent = QModelIndex()) const override;
        QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
        QHash<int, QByteArray> roleNames() const override;
    private:
        int thisModelSize{32};
    private:
        sstd_class(AddRemoveModel);
    };

}/*namespace sstd*/














