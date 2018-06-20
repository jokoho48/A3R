/*
 * Author: joko // Jonas
 * Request Frame Data from Extension
 *
 * Arguments:
 * 0: KeyFrame <String>
 *
 * Return Value:
 * FrameData
 *
 * Example:
 * Example
 *
 * Public: No
 */
#include "script_component.hpp"
params ["_keyFrame"];
private _ret = [];
while {
    private _r = ("ArmaAAR" callExtension format ["readFrame:%1", _keyFrame]);
    if (_r == "DONE") then {
        false;
    } else {
        _ret pushback call compile _r;
        true;
    };
} do {};
_ret;
