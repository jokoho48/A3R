/*
 * Author: joko//Jonas
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
[QGVAR(playStatusChanged), {

}] call CBA_fnc_addEventHandler;

[QGVAR(playSpeedChanged), {

}] call CBA_fnc_addEventHandler;

[QGVAR(timeLinePositionChanged), {
    params ["_newPos", "_oldPos"];
    
}] call CBA_fnc_addEventHandler;
