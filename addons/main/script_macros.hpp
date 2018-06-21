#include "\x\cba\addons\main\script_macros_common.hpp"

// UI Based Macros
#define PYN 108
#define PX(X) ((X)/PYN*safeZoneH/(4/3))
#define PY(Y) ((Y)/PYN*safeZoneH)

#ifdef PREP
	#undef PREP
#endif

#define PREP(fncName) [QUOTE(PATHTOF(functions\DOUBLES(fnc,fncName).sqf)), QFUNC(fncName)] call SLX_XEH_COMPILE_NEW
