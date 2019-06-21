﻿/* item_model_module/the_moudle.hpp */
#pragma once

#include <sstd_qt_qml_quick_library.hpp>

namespace sstd {

    class TheMoudle : public QQmlExtensionPlugin {
        Q_OBJECT
    private:
        Q_PLUGIN_METADATA(IID QQmlExtensionInterface_iid)
    public:
        void registerTypes(const char *uri) override;
    private:
        sstd_class(TheMoudle);
    };

}/*namespace sstd*/

/*endl_input_of_latex_for_clanguage_lick*/
