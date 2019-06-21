#pragma once

#include <sstd_qt_qml_quick_library.hpp>

namespace sstd{

    class KnowListModel : public QAbstractListModel {
        Q_OBJECT
    private:
        Q_PROPERTY(int theCount READ getTheCount WRITE setTheCount NOTIFY theCountChanged)
    public:
        enum AllRoles : int {
            BackGroundColorRole = Qt::UserRole + 1,
            ForeGroundColorRole,
        };
    public:
        inline int getTheCount() const;
        void setTheCount(const int &);
        Q_SIGNAL void theCountChanged();
    protected:
        int rowCount(const QModelIndex &parent = QModelIndex()) const override;
        QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
        QHash<int, QByteArray> roleNames() const override;
    private:
        int thisCount{ 1024 };
    private:
        sstd_class(KnowListModel);
    };

    inline int KnowListModel::getTheCount() const{
        return thisCount;
    }

}/*namespace sstd*/
















