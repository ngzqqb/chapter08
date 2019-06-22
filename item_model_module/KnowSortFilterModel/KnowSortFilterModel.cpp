#include "KnowSortFilterModel.hpp"

namespace sstd {

    using The = KnowSortFilterModel;

    class Item {
    public:
        QString key1;
        QString key2;
        QString key3;
    private:
        sstd_class(Item);
    };

    using Element = std::array<Item, 3>;
    using Elements = std::array< Element, 8 >;

    int The::columnCount(const QModelIndex &) const {
        return static_cast<int>(std::tuple_size_v< Element >);
    }

    int The::rowCount(const QModelIndex &) const {
        return static_cast<int>(std::tuple_size_v< Elements >);
    }

    QHash<int, QByteArray> The::roleNames() const {
        using T = QHash<int, QByteArray>;
        const static auto globalAns = []()->T {
            T varAns;
            varAns[Key1] = QByteArrayLiteral("key1");
            varAns[Key2] = QByteArrayLiteral("key2");
            varAns[Key3] = QByteArrayLiteral("key3");
            return std::move(varAns);
        }();
        return globalAns;
    }

#define QSL(...) QStringLiteral(__VA_ARGS__)
    inline static const Elements & getTestData() {
        const static Elements globalAns{
            Element{
                Item{QSL("0"),QSL("0"),QSL("A")},
                Item{QSL("0"),QSL("1"),QSL("B")},
                Item{QSL("0"),QSL("2"),QSL("C")}
            },
            Element{
                Item{QSL("1"),QSL("0"),QSL("D")},
                Item{QSL("1"),QSL("1"),QSL("E")},
                Item{QSL("1"),QSL("2"),QSL("F")}
            },
            Element{
                Item{QSL("2"),QSL("0"),QSL("G")},
                Item{QSL("2"),QSL("1"),QSL("H")},
                Item{QSL("2"),QSL("2"),QSL("I")}
            },
            Element{
                Item{QSL("3"),QSL("0"),QSL("J")},
                Item{QSL("3"),QSL("1"),QSL("K")},
                Item{QSL("3"),QSL("2"),QSL("L")}
            },
            Element{
                Item{QSL("4"),QSL("0"),QSL("M")},
                Item{QSL("4"),QSL("1"),QSL("N")},
                Item{QSL("4"),QSL("2"),QSL("O")}
            },
            Element{
                Item{QSL("5"),QSL("0"),QSL("P")},
                Item{QSL("5"),QSL("1"),QSL("Q")},
                Item{QSL("5"),QSL("2"),QSL("R")}
            },
            Element{
                Item{QSL("6"),QSL("0"),QSL("S")},
                Item{QSL("6"),QSL("1"),QSL("T")},
                Item{QSL("6"),QSL("2"),QSL("U")}
            },
            Element{
                Item{QSL("7"),QSL("0"),QSL("V")},
                Item{QSL("7"),QSL("1"),QSL("W")},
                Item{QSL("7"),QSL("2"),QSL("X")}
            },
        };
        return globalAns;
    }

    template <typename U>
    inline static std::size_t getRow(const U & arg) {
        return static_cast<std::size_t>(arg.row());
    }

    template <typename U>
    inline static std::size_t getColumn(const U & arg) {
        return static_cast<std::size_t>(arg.column());
    }

    QVariant The::data(const QModelIndex &index, int role) const {
        if (!index.isValid()) {
            return {};
        }
        if (index.row() < 0) {
            return {};
        }
        if (index.column() < 0) {
            return {};
        }
        const auto varRow = getRow(index);
        const auto varCol = getColumn(index);
        if (varRow >= std::tuple_size_v< Elements >) {
            return {};
        }
        if (varCol >= std::tuple_size_v< Element >) {
            return {};
        }
        const auto & varItem = getTestData()[varRow][varCol];
        switch (role) {
        case Key1:
        {
            return varItem.key1;
        }
        case Key2:
        {
            return varItem.key2;
        }
        case Key3:
        {
            return varItem.key3;
        }
        }
        return {};
    }

}/*namespace sstd*/
