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
}

/*endl_input_of_latex_for_clanguage_lick*/
