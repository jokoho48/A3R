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
    "",
    ["_deltaX", 0, [0]],
    ["_deltaY", 0, [0]]
];

if !(GVAR(mouseToLook)) exitWith {};

GVAR(CameraDir) = GVAR(CameraDir) + _deltaX * 0.5;
GVAR(CameraPitch) = -89.0 max (89.9 min (GVAR(CameraPitch) - _deltaY));

GVAR(CameraDir) = ((GVAR(CameraDir)) min 90) max - 90;
