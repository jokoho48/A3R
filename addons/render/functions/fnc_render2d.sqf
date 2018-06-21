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
hintSilent "Frame Renderd";
params [
    ["_map", controlNull, [controlNull]]
];

private _mapScale = ctrlMapScale _map;
private _size = 24;
private _textSize = PY(4);
if (_mapScale < 0.1) then {
    _textSize = _textSize * ((_mapScale / 0.1) max 0.5);
};
{
    _x params ["", "_name", "_pos", "_dir", "_type", "_alive", "_side", "_isLeader", "_grpName"];
    private _color = (GVAR(sideColors) select _side);
    private _icon = "\A3\ui_f\data\map\vehicleicons\iconMan_ca.paa";
    if !(_alive) then {
        _color = [0.3, 0.3, 0.3, 0.5];
        _icon = "\a3\ui_f_curator\data\cfgmarkers\kia_ca.paa";
        _dir = 0;
    } else {
        if (isText (configFile >> "CfgVehicles" >> _type >> "Icon")) then {
            _icon = getText (configFile >> "CfgVehicles" >> _type >> "Icon");
        };
    };
    _pos = +_pos;
    _pos set [2, 0];
    _map drawIcon [_icon, _color, _pos, _size, _size, _dir, "", 2, _textSize, "PuristaMedium", 'right'];
    _map drawIcon ["a3\ui_f\data\Map\Markers\System\dummy_ca.paa", [1, 1, 1, 1], _pos, _size, _size, 0, _name, 2, _textSize, "PuristaMedium", 'right'];
    nil
} count GVAR(FrameData);

{
    _x params ["", "_name", "_pos", "_dir", "_type", "_alive", "_side", "_isLeader", "_grpName"];
    _pos = +_pos;
    _pos set [2, 0];
    _pos = _map ctrlMapWorldToScreen _pos;
    _pos = [(_pos select 0) + -2 / 640, (_pos select 1) + -25 / 480];
    _pos = _map ctrlMapScreenToWorld _pos;
    _pos = _pos;
    private _grpIcon = "\A3\ui_f\data\map\markers\nato\b_inf.paa";
    private _color = (GVAR(sideColors) select _side);
    _map drawIcon [_grpIcon, _color, _pos, _size, _size, 0, "", 2, _textSize, "PuristaMedium", 'right'];
    _map drawIcon ["a3\ui_f\data\Map\Markers\System\dummy_ca.paa", [1, 1, 1, 1], _pos, _size, _size, 0, _grpName, 2, _textSize, "PuristaMedium", 'right'];
    nil
} count (GVAR(FrameData) select {_x select 7});
