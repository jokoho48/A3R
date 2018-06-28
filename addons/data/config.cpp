#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"A3R_main"};
        author = "joko // Jonas";
        authors[] = {"joko // Jonas"};
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
