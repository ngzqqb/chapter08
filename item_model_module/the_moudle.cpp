/* item_model_module/the_moudle.cpp */

#include "the_moudle.hpp"
#include "Empty.hpp"

#include "ConcatenateTablesProxyModel/ConcatenateTablesProxyModel.hpp"
#include "IdentityProxyModel/IdentityProxyModel.hpp"
#include "ItemSelectionModel/ItemSelectionModel.hpp"
#include "SortFilterProxyModel/SortFilterProxyModel.hpp"
#include "TransposeProxyModel/TransposeProxyModel.hpp"

void sstd::TheMoudle::registerTypes(const char * argURI) {
    qmlRegisterType<Empty>(argURI, 1, 0, "Empty");
    qmlRegisterType<ConcatenateTablesProxyModel>(argURI, 1, 0, "ConcatenateTablesProxyModel");
    qmlRegisterType<IdentityProxyModel>(argURI, 1, 0, "IdentityProxyModel");
    qmlRegisterType<ItemSelectionModel>(argURI, 1, 0, "ItemSelectionModel");
    qmlRegisterType<SortFilterProxyModel>(argURI, 1, 0, "SortFilterProxyModel");
    qmlRegisterType<TransposeProxyModel>(argURI, 1, 0, "TransposeProxyModel");
}

/*endl_input_of_latex_for_clanguage_lick*/
