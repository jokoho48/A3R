#include "script_component.hpp"
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
params ["_fileName"];
"ArmaAAR" callExtension format ["exportFrameData;%1", _fileName];
