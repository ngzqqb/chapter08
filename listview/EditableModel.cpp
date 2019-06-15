#include "EditableModel.hpp"

namespace sstd {

    int EditableModel::rowCount(const QModelIndex &) const {
        return  static_cast<int>(thisItemsVector.size());
    }

    QVariant EditableModel::data(const QModelIndex &index, int role) const {
        if (index.isValid()) {
            const auto varIndex = index.row();
            if ((varIndex < rowCount()) && (varIndex > -1)) {
                if (role == BackGroundColorRole) {
                    return QColor((varIndex) & 255,
                        ((varIndex << 4) - 64) & 255,
                        ((varIndex << 4) + 64) & 255);
                } else if (role == ShowTextRole) {
                    return thisItemsVector[static_cast<std::size_t>(varIndex)]->text;
                }
            }
        }
        return {};
    }

    QHash<int, QByteArray> EditableModel::roleNames() const {
        using T = QHash<int, QByteArray>;
        static const T globalAns = []() -> T {
            T varAns;
            varAns[BackGroundColorRole] = QByteArrayLiteral("theBackgroundColor");
            varAns[ShowTextRole] = QByteArrayLiteral("theShowText");
            return std::move(varAns);
        }();
        return globalAns;
    }

    bool EditableModel::setData(const QModelIndex &index, const QVariant &value, int role) {
        if (index.isValid() && (index.row() < rowCount()) && (index.row() > -1)) {
            if (role == ShowTextRole) {
                auto & varThisData = thisItemsVector[static_cast<std::size_t>(index.row())];
                QString varSetString;
                {
                    QVariant varValue = value;
                    if (varValue.convert(qMetaTypeId<QString>())) {
                        varSetString = varValue.value<QString>();
                    }
                }
                if (varThisData->text != varSetString) {
                    varThisData->text = std::move(varSetString);
                    this->dataChanged(index, index, { role });
                    return true;
                }
            }
        }
        return Super::setData(index, value, role);
    }

    Qt::ItemFlags EditableModel::flags(const QModelIndex & index) const {
        return Super::flags(index) | Qt::ItemIsEditable;
    }

    EditableModel::EditableModel() {
        thisItemsVector.resize(128);
        for (auto & varI : thisItemsVector) {
            varI = sstd_make_shared<ItemData>();
        }
        thisTimerIndex = this->startTimer(2500ms);
    }

    void EditableModel::timerEvent(QTimerEvent *event) {
        if (event->timerId() == thisTimerIndex) {
            const auto varCount = this->rowCount();
            for (int varI = 0; varI < varCount; ++varI) {
                auto varText = thisItemsVector[static_cast<std::size_t>(varI)]->text;
                if (varText.indexOf(QStringLiteral("测试数据")) < 0) {
                    varText = QStringLiteral("测试数据") + varText;
                }
                this->setData(this->index(varI),
                    std::move(varText),
                    ShowTextRole);
            }
        } else {
            Super::timerEvent(event);
        }
    }


}/*namesapce sstd*/

inline static void registerThis() {
    qmlRegisterType<sstd::EditableModel>("sstd.listview", 1, 0, "EditableModel");
}

Q_COREAPP_STARTUP_FUNCTION(registerThis)















