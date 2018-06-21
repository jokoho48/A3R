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
{
    _x params ["", "_name", "_pos", "", "", "_alive", "_side", "_isLeader", "_grpName"];
    private _sideColor = (GVAR(sideColors) select _side);
    private _distance = (positionCameraToWorld [0, 0, 0]) distance _pos;
    _pos = +_pos;
    _pos set [2, (_pos select 2) - (getTerrainHeightASL _pos)];
    if (_distance < 200 && {_distance < (getObjectViewDistance select 0)}) then {
        private _screenPos = worldToScreen _pos;
        if (_screenPos isEqualTo []) exitWith {nil};

        private _pos = _pos vectorAdd [0, 0, (0.4 max 0.25*((_distance/2)^0.8)) min 1.5];
        private _size = (0.4 max (0.5 / ((_distance/30)^0.8))) min 1;

        private _scale = 1 + 0.4;
        private _nametagVisibility = 1 - (((_screenPos distance [0.5, 0.5])/(0.5*safeZoneH*((16/9) min (safeZoneW/safeZoneH))))^2 min 1);
        private _alpha =  (0.3+0.7)*(0.5+0.5*_nametagVisibility);
        _sideColor set [3, _alpha];
        private _icon = "a3\ui_f_curator\data\cfgcurator\entity_selected_ca.paa";
        if (!_alive) then {
            _icon = "\a3\ui_f_curator\data\cfgmarkers\kia_ca.paa";
            _sideColor set [0, 0.3];
            _sideColor set [1, 0.3];
            _sideColor set [2, 0.3];
        };
        drawIcon3D [_icon, _sideColor, _pos, _size * _scale, _size * _scale, 0];
        drawIcon3D ["\a3\ui_f\data\igui\cfg\actions\clear_empty_ca.paa", [1, 1, 1, _alpha*_nametagVisibility], _pos, _size*1.4, _size*1.4, 0, _name, 2, PY(1.8), "RobotoCondensed", "center"];
    } else {
        if (_distance < 1000) then {
            _sideColor set [3, 0.4];
            private _scale = 1 + 0.4;
            drawIcon3D ["a3\ui_f_curator\data\cfgcurator\entity_selected_ca.paa", _sideColor, _pos, 0.4*_scale, 0.4*_scale, 0];
        };
    };

    if (_isLeader) then {
        private _pos = _pos vectorAdd [0, 0, 10 min (2 max (_distance * 30 / 150)^0.8)];
        private _screenPos = worldToScreen _pos;
        if (_screenPos isEqualTo []) exitWith {nil};

        private _groupMapIcon = "\A3\ui_f\data\map\markers\nato\b_inf.paa";
        private _size = (1.5 min (0.2 / (_distance / 5000))) max 0.7;
        private _alpha =  0.5 + 0.5;
        _sideColor set [3, 0.7*_alpha];
        drawIcon3D [_groupMapIcon, _sideColor, _pos, _size, _size, 0];
        if (_distance < 4 * 1000) then {
            private _fontSize = PY(2.5);
            if (_distance > 1000) then {
                _fontSize = PY(2);
            };

            if (_distance > 2 * 1000) then {
                _fontSize = PY(1.8);
            };
            drawIcon3D ["", [1, 1, 1, _alpha], _pos, _size, _size, 0, _grpName, 2, _fontSize, "RobotoCondensedBold", "center"];
        };
    };
    nil
} count GVAR(FrameData);
