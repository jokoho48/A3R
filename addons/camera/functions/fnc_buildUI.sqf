/*
 * Author: Badguy
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

/*
GVAR(Camera) = "Camera" camCreate (eyePos player);
GVAR(Camera) cameraEffect ["internal", "back"];
player attachTo [GVAR(Camera), [0, 0, 0]];
GVAR(CameraPos) = (eyePos player) vectorAdd [0, 0, 50];
showCinemaBorder false;
cameraEffectEnableHUD true;
player hideObjectGlobal true;
player enableSimulationGlobal false;
player allowDamage false;
*/

private _display = (findDisplay 49) createDisplay "RscDisplayEmpty";
uiNamespace setVariable [QGVAR(Display), _display];

_display displayAddEventHandler ["MouseButtonDown", {
    params ["_ctrl", "_button", "_mouseX"];
    GVAR(mouseToLook) = true;
}];

_display displayAddEventHandler ["MouseButtonUp", {
    params ["_ctrl", "_button", "_mouseX"];
    GVAR(mouseToLook) = false;
}];
/*
_display displayAddEventHandler ["KeyDown", {
    params ["_display", "_dikCode"];

    if (_dikCode != 1) exitWith {false};

    for "_i" from 1 to 9 do {
        private _controlGroup = _display displayCtrl (_i * 100);
        _controlGroup ctrlShow false;
    };

    createDialog (["RscDisplayInterrupt", "RscDisplayMPInterrupt"] select isMultiplayer);
    private _dialog = findDisplay 49;

    // Disable all buttons first
    for "_i" from 100 to 2000 do {
        (_dialog displayCtrl _i) ctrlEnable false;
        (_dialog displayCtrl _i) ctrlSetTooltip "";
    };

    private _control = _dialog displayCtrl 104;
    _control ctrlSetEventHandler ["buttonClick", QUOTE((uiNamespace getVariable QUOTE(QGVAR(Display))) closeDisplay 2; closeDialog 0; failMission ""LOSER"";)];
    _control ctrlEnable true;
    _control ctrlSetText "ABORT";

    [{!dialog}, {
        params ["_display"];

        for "_i" from 1 to 9 do {
            private _controlGroup = _display displayCtrl (_i * 100);
            _controlGroup ctrlShow true;
        };
    }, _display] call CBA_fnc_waitUntilAndExecute;
    true
}];
*/
private _ctrlGrpGlobal = _display ctrlCreate ["RscControlsGroupNoScrollbars", -1];
_ctrlGrpGlobal ctrlSetPosition [safeZoneX, safeZoneY, safeZoneW, safeZoneH];
_ctrlGrpGlobal ctrlCommit 0;

private _ctrlGrpVideoCtrl = _display ctrlCreate ["RscControlsGroupNoScrollbars", -1, _ctrlGrpGlobal];
_ctrlGrpVideoCtrl ctrlSetPosition [safeZoneW/2 - (safeZoneW*0.7)/2, safeZoneH - PY(5), (safeZoneW*0.7), PY(3)];
_ctrlGrpVideoCtrl ctrlCommit 0;

private _ctrlGrpVideoCtrlBackground = _display ctrlCreate ["RscPicture", -1, _ctrlGrpVideoCtrl];
_ctrlGrpVideoCtrlBackground ctrlSetPosition [0, 0, (safeZoneW*0.7), PY(3)];
_ctrlGrpVideoCtrlBackground ctrlSetText "#(argb,8,8,3)color(0.3,0.3,0.3,0.5)";
_ctrlGrpVideoCtrlBackground ctrlCommit 0;

private _ctrlGrpTimeline = _display ctrlCreate ["RscControlsGroupNoScrollbars", -1, _ctrlGrpVideoCtrl];
_ctrlGrpTimeline ctrlSetPosition [PX(7), PY(1), (safeZoneW*0.7) - PX(7.5), PY(1)];
_ctrlGrpTimeline ctrlSetBackgroundColor [0, 0, 0, 1];
_ctrlGrpTimeline ctrlCommit 0;

private _ctrlGrpTimelineBackground = _display ctrlCreate ["RscPicture", -1, _ctrlGrpTimeline];
_ctrlGrpTimelineBackground ctrlSetPosition [0, 0, (safeZoneW*0.7) - PX(7.5), PY(1)];
_ctrlGrpTimelineBackground ctrlSetText "#(argb,8,8,3)color(0,0,0,0.5)";
_ctrlGrpTimelineBackground ctrlCommit 0;

private _ctrlTimelineProgress = _display ctrlCreate ["RscProgress", -1, _ctrlGrpTimeline];
_ctrlTimelineProgress ctrlSetPosition [0, 0, (safeZoneW*0.7) - PX(7.5), PY(1)];
_ctrlTimelineProgress ctrlSetTextColor [1, 1, 1, 1];
_ctrlTimelineProgress progressSetPosition 0;
_ctrlTimelineProgress ctrlCommit 0;

uiNamespace setVariable [QGVAR(CtrlTimelineProgress), _ctrlTimelineProgress];

FUNC(updateProgress) = {
    params ["_mouseX"];
    private _ctrl = uiNamespace getVariable QGVAR(CtrlTimelineProgress);
    private _pos = ctrlPosition _ctrl;

    _pos = (_mouseX - PX(7) ) / (_pos select 2);
    private _oldPos = progressPosition _ctrl;
    if (_pos != _oldPos) then {
        [QGVAR(timeLinePositionChanged), [_pos, _oldPos]] call CBA_fnc_localEvent;
        _ctrl progressSetPosition _pos;
    };
};

_ctrlGrpTimeline ctrlAddEventHandler ["MouseButtonDown", {
    params ["", "_button", "_mouseX"];
    if (_button == 0) then {
        [_mouseX] call FUNC(updateProgress);
        GVAR(TimelineActive) = true;
    };
}];
_ctrlGrpTimeline ctrlAddEventHandler ["MouseButtonUp", {
    params ["", "_button"];
    if (_button == 0) then {
        GVAR(TimelineActive) = false;
    };
}];

_ctrlGrpTimeline ctrlAddEventHandler ["MouseMoving", {
    params ["", "_mouseX"];
    if (GVAR(TimelineActive)) then {
        [_mouseX] call FUNC(updateProgress);
    };
}];

private _ctrlGroupPlayButton = _display ctrlCreate ["RscControlsGroupNoScrollbars", -1, _ctrlGrpVideoCtrl];
_ctrlGroupPlayButton ctrlSetPosition [0, 0, PX(3), PY(3)];
_ctrlGroupPlayButton ctrlCommit 0;

private _ctrlPlayButtonBackground = _display ctrlCreate ["RscPicture", -1, _ctrlGroupPlayButton];
_ctrlPlayButtonBackground ctrlSetPosition [0, 0, PX(3), PY(3)];
_ctrlPlayButtonBackground ctrlSetText "#(argb,8,8,3)color(0,0,0,0)";
_ctrlPlayButtonBackground ctrlCommit 0;
_ctrlGroupPlayButton setVariable [QGVAR(background), _ctrlPlayButtonBackground];

GVAR(isPlaying) = false;
private _ctrlPlayButtonIcon = _display ctrlCreate ["RscPicture", -1, _ctrlGroupPlayButton];
_ctrlPlayButtonIcon ctrlSetPosition [0, 0, PX(3), PY(3)];
_ctrlPlayButtonIcon ctrlSetText "\A3\3den\Data\Attributes\ComboPreview\play_ca.paa";
_ctrlPlayButtonIcon ctrlSetTextColor [1, 1, 1, 1];
_ctrlPlayButtonIcon ctrlCommit 0;
_ctrlGroupPlayButton setVariable [QGVAR(icon), _ctrlPlayButtonIcon];
_ctrlGroupPlayButton ctrlAddEventHandler ["MouseButtonClick", {
    params ["_ctrlGrp", "_button"];

    GVAR(isPlaying) = !GVAR(isPlaying);
    [QGVAR(playStatusChanged), GVAR(isPlaying)] call CBA_fnc_localEvent;

    private _icon = _ctrlGrp getVariable [QGVAR(icon), controlNull];
    _icon ctrlSetText (["\A3\3den\Data\Attributes\ComboPreview\play_ca.paa", "\jk\A3R\addons\camera\UI\pause_ca.paa"] select GVAR(isPlaying));
    _icon ctrlCommit 0;
    DUMP(_this);
}];

private _ctrlGroupSpeedButton = _display ctrlCreate ["RscControlsGroupNoScrollbars", -1, _ctrlGrpVideoCtrl];
_ctrlGroupSpeedButton ctrlSetPosition [PX(3), 0, PX(3), PY(3)];
_ctrlGroupSpeedButton ctrlCommit 0;

private _ctrlSpeedButtonBackground = _display ctrlCreate ["RscPicture", -1, _ctrlGroupSpeedButton];
_ctrlSpeedButtonBackground ctrlSetPosition [0, 0, PX(3), PY(3)];
_ctrlSpeedButtonBackground ctrlSetText "#(argb,8,8,3)color(0,0,0,0)";
_ctrlSpeedButtonBackground ctrlCommit 0;
_ctrlGroupSpeedButton setVariable [QGVAR(background), _ctrlSpeedButtonBackground];

private _ctrlSpeedButtonText = _display ctrlCreate ["RscText", -1, _ctrlGroupSpeedButton];
_ctrlSpeedButtonText ctrlSetPosition [0, 0, PX(3), PY(3)];
_ctrlSpeedButtonText ctrlSetFontHeight PY(2.4);
_ctrlSpeedButtonText ctrlSetFont "RobotoCondensed";
_ctrlSpeedButtonText ctrlSetTextColor [1, 1, 1, 1];
_ctrlSpeedButtonText ctrlSetBackgroundColor [0, 0, 0, 0];
_ctrlSpeedButtonText ctrlSetText format ["%1x", GVAR(PlayingSpeed)];
_ctrlSpeedButtonText ctrlCommit 0;
_ctrlGroupSpeedButton setVariable [QGVAR(text), _ctrlSpeedButtonText];

_ctrlGroupSpeedButton ctrlAddEventHandler ["MouseButtonClick", {
    params ["_ctrlGrp", "_button"];
    switch (_button) do {
        case (0): {
            GVAR(PlayingSpeed) = GVAR(PlayingSpeed) + 1;
        };
        case (1): {
            GVAR(PlayingSpeed) = GVAR(PlayingSpeed) - 1;
        };
        case (2): {
            GVAR(PlayingSpeed) = 1;
        };
        default {
            DUMP("Not Bind Mouse Button");
        };
    };
    GVAR(PlayingSpeed) = GVAR(PlayingSpeed) max 1;
    GVAR(PlayingSpeed) = GVAR(PlayingSpeed) min 10;
    [QGVAR(PlaySpeedChanged), GVAR(PlayingSpeed)] call CBA_fnc_localEvent;
    private _buttonText = _ctrlGrp getVariable [QGVAR(text), controlNull];
    _buttonText ctrlSetText format ["%1x", GVAR(PlayingSpeed)];
    _buttonText ctrlCommit 0;
    DUMP(_this);
}];


// Button Effect
{
    _x ctrlAddEventHandler ["MouseEnter", {
        DUMP("MouseEnter");
        private _ctrl = _this getVariable [QGVAR(background), controlNull];
        if !(isNull _ctrl) then {
            _ctrl ctrlSetText "#(argb,8,8,3)color(0,0,0,1)";
            _ctrl ctrlSetBackgroundColor [0, 0, 0, 1];
            _ctrl ctrlCommit 0.3;
        };
    }];

    _x ctrlAddEventHandler ["MouseExit", {
        DUMP("MouseExit");
        private _ctrl = _this getVariable [QGVAR(background), controlNull];
        if !(isNull _ctrl) then {
            _ctrl ctrlSetText "#(argb,8,8,3)color(0,0,0,0)";
            _ctrl ctrlSetBackgroundColor [0, 0, 0, 0];
            _ctrl ctrlCommit 0.3;
        };
    }];
    nil
} count [_ctrlGroupPlayButton, _ctrlGroupSpeedButton];
