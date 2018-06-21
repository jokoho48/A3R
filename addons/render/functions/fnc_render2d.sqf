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
params [
    ["_map", controlNull, [controlNull]]
];

{
    _x params ["", "_name", "_pos", "_dir", "_type", "_alive", "_side", "_isLeader", "_grpName"];
    private _icon = "\A3\ui_f\data\map\vehicleicons\iconMan_ca.paa";
    private _color = [1, 1, 1, 1]; // TODO make Side Sensitive
    if !(_alive) then {
        _icon = ""; // TODO: Find Icon
        _color = [0.5, 0.5, 0.5, 0.5];
    } else {
        if (isText (configFile >> "CfgVehicles" >> _type >> "Icon")) then {
            _icon = getText (configFile >> "CfgVehicles" >> _type >> "Icon");
        };
    };
    _map drawIcon [_icon, _color, _pos, 24, 24, _dir, _name, 1, 1, "PuristaMedium", 'right'];
    nil
} count GVAR(FrameData);
