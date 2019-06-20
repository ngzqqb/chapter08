#include <sstd_qt_qml_quick_library.hpp>

namespace sstd {

    class EditableModel : public QAbstractListModel {
        Q_OBJECT
    public:
        enum AllRoles : int {
            BackGroundColorRole = Qt::UserRole + 1,
            ShowTextRole,
        };
    public:
        EditableModel();
    protected:
        int rowCount(const QModelIndex &parent = QModelIndex()) const override;
        QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
        bool setData(const QModelIndex &index, const QVariant &value, int role = Qt::EditRole) override;
        QHash<int, QByteArray> roleNames() const override;
        Qt::ItemFlags flags(const QModelIndex &index) const override;
    private:
        class ItemData {
        public:
            QString text;
        private:
            sstd_class(ItemData);
        };
        using ItemsVector = std::vector< std::shared_ptr<ItemData>,
            sstd::allocator< std::shared_ptr<ItemData> > >;
        ItemsVector thisItemsVector;
        using Super = QAbstractListModel;
        int thisTimerIndex{ 0 };
    private:
        sstd_class(EditableModel);
    };

}/*namespace sstd*/





