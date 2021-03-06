#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.hpp"

GVAR(FrameData) = [];
GVAR(isViewing) = ([0, getNumber (missionConfigFile >> "A3R_isViewing")] select (isNumber (missionConfigFile >> "A3R_isViewing"))) isEqualTo 1;

// [sideUnknown, sideEnemy, sideEmpty, sideFriendly, sideLogic, civilian, west, east, independent]
GVAR(sideColors) = [];
GVAR(sideColors) pushback [0.4, 0, 0.5, 1]; // Unkown
GVAR(sideColors) pushback [0.6, 0, 0, 1]; // Enemy
GVAR(sideColors) pushback [0.93, 0.7, 0.01, 0.6]; // Empty
GVAR(sideColors) pushback [0, 0.4, 0.8, 1]; // Friendly
GVAR(sideColors) pushback [0, 0.4, 0.8, 1]; // Friendly
GVAR(sideColors) pushback [0.4, 0, 0.5, 1]; // civilian
GVAR(sideColors) pushback [0, 0.4, 0.8, 1]; // west
GVAR(sideColors) pushback [0.6, 0, 0, 1]; // east
GVAR(sideColors) pushback [0, 0.5, 0, 1]; // indi

GVAR(TimelineActive) = false;
GVAR(frameCount) = 0;
GVAR(prevFrameID) = -1;
GVAR(FrameID) = 1;
GVAR(PlayingSpeed) = 1;

GVAR(mouseToLook) = false;
GVAR(Camera) = objNull;
GVAR(CameraPos) = [0, 0, 0];
GVAR(CameraDir) = 0;
GVAR(CameraPitch) = 0;
GVAR(deltaTime) = 0.025;
GVAR(prevTime) = time;
ADDON = true;
