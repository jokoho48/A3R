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
private _tempDir = GVAR(CameraDir);
private _forward = [sin _tempDir, cos _tempDir, 0];
private _right = [cos _tempDir, -sin _tempDir, 0];

private _velocity = [0, 0, 0];
if (GVAR(InputMode) == 0) then {
    if (inputAction "cameraMoveForward" > 0) then {
        _velocity = _velocity vectorAdd (_forward vectorMultiply (inputAction "cameraMoveForward"));
    };
    if (inputAction "cameraMoveBackward" > 0) then {
        _velocity = _velocity vectorDiff (_forward vectorMultiply (inputAction "cameraMoveBackward"));
    };
    if (inputAction "cameraMoveRight" > 0) then {
        _velocity = _velocity vectorAdd (_right vectorMultiply (inputAction "cameraMoveRight"));
    };
    if (inputAction "cameraMoveLeft" > 0) then {
        _velocity = _velocity vectorDiff (_right vectorMultiply (inputAction "cameraMoveLeft"));
    };
    if (inputAction "cameraMoveUp" > 0) then {
        _velocity = _velocity vectorAdd [0, 0, inputAction "cameraMoveUp"];
    };
    if (inputAction "cameraMoveDown" > 0) then {
        _velocity = _velocity vectorAdd [0, 0, -inputAction "cameraMoveDown"];
    };
};

private _deltaX = (inputAction "cameraLookRight" - inputAction "cameraLookLeft") * 2;
private _deltaY = (inputAction "cameraLookDown" - inputAction "cameraLookUp") * 2;
if (_deltaX != 0 || _deltaY != 0) then {
    [displayNull, _deltaX, _deltaY] call FUNC(mouseMovingEH);
};

GVAR(CameraPos) = GVAR(CameraPos) vectorAdd (_velocity vectorMultiply (((getPos GVAR(Camera)) select 2) * GVAR(deltaTime)));

private _position = GVAR(CameraPos);
private _direction = GVAR(CameraDir) + GVAR(CameraDirOffset);
private _pitch = GVAR(CameraPitch) + GVAR(CameraPitchOffset);

GVAR(Camera) setPosASL _position;
GVAR(Camera) setVectorDirAndUp [[sin _direction * cos _pitch, cos _direction * cos _pitch, sin _pitch], [0, 0, cos _pitch]];
