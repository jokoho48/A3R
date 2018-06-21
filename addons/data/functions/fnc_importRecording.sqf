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
params ["_fileName"];
"ArmaAAR" callExtension format ["importFrameData;%1", _fileName];
