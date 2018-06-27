#include "script_component.hpp"
if !(GVAR(isViewing)) exitWith {};
GVAR(frameCount) = call EFUNC(data,frameCount);
addMissionEventHandler ["Draw3D", {
    call FUNC(render3d);
}];

[
    {
        !(isNull ((findDisplay 12) displayCtrl 51))
    }, {
        ((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ["Draw", {
            _this call FUNC(render2d);
        }];
    }
] call CBA_fnc_waitUntilAndExecute;
