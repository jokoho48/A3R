#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.hpp"

GVAR(UpdateTimeDelay) = [1, getNumber (missionConfigFile >> "A3R_UpdateTimeDelay")] select (isNumber (missionConfigFile >> "A3R_UpdateTimeDelay")); // TODO: CBA Settings
GVAR(isRecording) = [0, getNumber (missionConfigFile >> "A3R_record")] select (isNumber (missionConfigFile >> "A3R_record")) isEqualTo 1;
GVAR(MaxPerFrame) = [25, getNumber (missionConfigFile >> "A3R_FrameCount")] select (isNumber (missionConfigFile >> "A3R_FrameCount"));
diag_log format ["(%1)[A3R Log: Data] Extension Version %1", "ArmaAAR"callExtension "version"];

ADDON = true;
