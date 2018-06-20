#include "script_component.hpp"

"ArmaAAR" callExtension "ClearFrameData";
[{
    call FUNC(loop);
}, 0] call CBA_fnc_addPerFrameHandler;
