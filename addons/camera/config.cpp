#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"A3R_data"};
        author = "joko // Jonas & Badguy";
        authors[] = {"joko // Jonas", "Badguy"};
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
