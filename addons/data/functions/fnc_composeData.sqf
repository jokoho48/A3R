/*
 * Author: joko // Jonas
 * Composes Data to Send of To Extension
 *
 * Arguments:
 * None
 *
 * Return Value:
 * All Frame Data
 *
 * Example:
 * private _data = call A3R_data_fnc_composeData;
 *
 * Public: No
 */
#include "script_component.hpp"
private _allTrackedUnits = allUnits;
_allTrackedUnits append allDeadMen;
GVAR(FrameID) = GVAR(FrameID) + 1;
_allTrackedUnits apply {
    [
        GVAR(FrameID),
        name _x,
        getPosASLVisual _x,
        getDirVisual _x,
        typeOf _x,
        alive _x,
        [sideUnknown, sideEnemy, sideEmpty, sideFriendly, sideLogic, civilian, west, east, independent] find (side _x),
        leader _x == _x,
        groupID (group _x)
    ];
};
