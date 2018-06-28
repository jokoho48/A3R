#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"cba_common"};
        author = "joko // Jonas";
        authors[] = {"joko // Jonas"};
        authorUrl = "https://github.com/jokoho48/A3R";
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
