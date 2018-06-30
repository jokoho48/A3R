#include "script_component.hpp"
/*
 * Author: joko // Jonas
 * Description
 *
 * Arguments:
 * 0: Arguments
 *
 * Return Value:
 * Return
 *
 * Example:
 * Example
 *
 * Public: No
 */

if (GVAR(UpdateTimeDelay) + GVAR(LastTime) >= diag_tickTime) then {
    {
        [GVAR(FrameID), _x] call FUNC(sendData);
    } forEach GVAR(FrameData);
    GVAR(FrameData) = call FUNC(composeData);
    GVAR(LastTime) = diag_tickTime;
    if ((GVAR(FrameID) mod 10) == 1) then {
        [GVAR(FrameID), ["ENVDATA", wind, windDir, date, overcast, fog, fogParams, rain, rainbow]] call FUNC(sendData);
    };
};

for "_i" from 0 to GVAR(MaxPerFrame) max ((count GVAR(FrameData)) - 1) do {
    [GVAR(FrameID), (GVAR(FrameData) deleteAt 0)] call FUNC(sendData);
};
