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
#include "script_component.hpp"

if (GVAR(UpdateTimeDelay) + GVAR(LastTime) >= diag_tickTime) then {
    {
        _x call FUNC(sendData);
    } forEach GVAR(FrameData);
    GVAR(FrameData) = call FUNC(composeData);
    GVAR(LastTime) = diag_tickTime
};

for "_i" from 0 to GVAR(MaxPerFrame) max ((count GVAR(FrameData)) - 1) do {
     (GVAR(FrameData) deleteAt 0) call FUNC(sendData);
};
