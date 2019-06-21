﻿#include "SortFilterProxyModel.hpp"

namespace sstd {

    using The = SortFilterProxyModel;

    void The::setLessThanFunction(const QJSValue & arg) {
        if (!arg.isCallable()) {
            qWarning() << "there need a js function !";
            return;
        }
        if (thisLessThanFunction) {
            if ((*thisLessThanFunction).strictlyEquals(arg)) {
                return;
            }
        }
        thisLessThanFunction.emplace(arg);
        this->layoutChanged();
        lessThanFunctionChanged();
    }

    bool The::lessThan(const QModelIndex &source_left, const QModelIndex &source_right) const {
        if (thisLessThanFunction) {
            using T = QJSValue;
            QJSValueList varArgs{
                T{source_left.row()},
                T{source_left.column()},
                T{source_right.row()},
                T{source_right.column()}
            };
            auto varFunction = *thisLessThanFunction;
            const auto varAns = varFunction.call(std::move(varArgs));
            if (varAns.isBool()) {
                return varAns.toBool();
            } else {
                qWarning() << varAns.toString();
            }
        }
        return true;
    }

}/*namespace sstd*/
