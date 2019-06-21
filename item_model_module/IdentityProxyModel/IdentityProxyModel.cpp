#include "IdentityProxyModel.hpp"

namespace sstd {

    using The = IdentityProxyModel;

    QHash<int, QByteArray> The::roleNames() const {
        assert( sourceModel() );
        auto varSourceModel = sourceModel();
        auto varAns = varSourceModel->roleNames();
        assert(varAns.find(AttachedTextRole) == varAns.end());
        varAns[AttachedTextRole] = QByteArrayLiteral("theAttachedText");
        return std::move(varAns);
    }

    QVariant The::data(const QModelIndex &proxyIndex, int role) const {
        if (role == AttachedTextRole) {
            return thisAttachedText;
        }
        return Super::data(proxyIndex,role);
    }

    void The::setTheAttachedText(const QString & arg) {
        if ( arg == thisAttachedText ) {
            return;
        }
        thisAttachedText = arg;
        this->layoutChanged();
        theAttachedTextChanged();
    }

}

