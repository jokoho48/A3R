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
        str GVAR(FrameID),
        name _x,
        str (getPosASLVisual _x),
        str (getDirVisual _x),
        str ([sideUnknown, sideEnemy, sideEmpty, sideFriendly, civilian, west, east, independent] find (side _x))
    ];
};
