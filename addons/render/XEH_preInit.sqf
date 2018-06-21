#include "script_component.hpp"

ADDON = false;

GVAR(FrameData) = [];
GVAR(isViewing) = [0, getNumber (missionConfigFile >> "A3R_isViewing")] select (isNumber (missionConfigFile >> "A3R_isViewing")) isEqualTo 1;
#include "XEH_PREP.hpp"

ADDON = true;
