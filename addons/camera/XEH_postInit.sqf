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

[{
    GVAR(deltaTime) = time - GVAR(prevTime);
    GVAR(prevTime) = time;
    if (GVAR(prevFrameID) != GVAR(FrameID)) then {
        private _index = GVAR(FrameData) findIf {(_x select 0) isEqualTo "ENVDATA"};
        if (_index != -1) then {
            (GVAR(FrameData) select _index) params ["", "_wind", "_windDir", "_date", "_overcast", "_fog", "_fogParams", "_rain", "_rainbow"];
            _wind set [2, true];
            setWind _wind;
            1 setWindDir _windDir;
            setDate _date;
            1 setOvercast _overcast;
            1 setRain _rain;
            1 setRainbow _rainbow;
            1 setFog _fog;
            1 setFog _fogParams;
        };
        GVAR(prevFrameID) = GVAR(FrameID);
    };
    call FUNC(cameraUpdate);
}, 0] call CBA_fnc_addPerframeHandler;

[
    {!(isNull (findDisplay 49))},
    {call FUNC(buildUI)}
] call CBA_fnc_waitUntilAndExecute;
