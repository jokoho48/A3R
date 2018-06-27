#include "script_component.hpp"
if !(EGVAR(render,isViewing)) exitWith {};

// Var Def
GVAR(mouseToLook) = false;
GVAR(Camera) = objNull;
GVAR(CameraPos) = [0, 0, 0];
GVAR(CameraDir) = 0;
GVAR(CameraPitch) = 0;

[
    {!(isNull (findDisplay 49))},
    {call FUNC(buildUI)}
] call CBA_fnc_waitUntilAndExecute;
[{
    call FUNC(cameraUpdate);
}, 0] call CBA_fnc_addPerFrameHandler;
