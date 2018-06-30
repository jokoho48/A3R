#include "script_component.hpp"
/*
 * Author: joko // Jonas
 * Sends Data to the Extension
 *
 * Arguments:
 * Frame Data
 *
 * Return Value:
 * None
 *
 * Example:
 * Example
 *
 * Public: No
 */
params ["_keyFrame", "_data"];
"ArmaAAR" callExtension format ["setFrameData;%1;%2", _keyFrame, _data];
