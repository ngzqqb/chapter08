#include <sstd_qt_qml_quick_library.hpp>

namespace sstd {

    class VeryLargeModel : public QAbstractListModel {
        Q_OBJECT
    public:
        enum AllRoles : int {
            BackGroundColorRole = Qt::UserRole + 1,
            ForeGroundColorRole,
        };
    public:
        VeryLargeModel();
    protected:
        int rowCount(const QModelIndex &parent = QModelIndex()) const override;
        QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
        QHash<int, QByteArray> roleNames() const override;
    private:
        sstd_class(VeryLargeModel);
    };

}/*namespace sstd*/





