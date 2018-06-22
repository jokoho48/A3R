#include "script_component.hpp"

if (!GVAR(isRecording)) exitWith {};
if (call FUNC(frameCount) != 0) then {
    format ["A3R_Recording_%1_%2", name player, diag_tickTime] call FUNC(exportRecording);
    call FUNC(clearFrameData);
};
[{
    call FUNC(loop);
}, 0] call CBA_fnc_addPerFrameHandler;

["CAManBase", "FiredMan", {
    params ["_unit", "_weapon", "", "", "", "", "", "_vehicle"];
    _unit setVariable [QGVAR(lastFrameShot), [GVAR(FrameID) + 1, _vehicle weaponDirection _weapon]];
}] call CBA_fnc_addClassEventHandler;
