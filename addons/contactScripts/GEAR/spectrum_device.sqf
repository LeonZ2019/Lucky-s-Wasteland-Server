private ["_fRange", "_selRange", "_selCenter"];

while {true} do
{
	waitUntil {
		sleep 0.2;
		currentWeapon player == "hgun_esd_01_F"
	};
	_fRange = switch((handgunItems player) select 0) do
	{
		case "muzzle_antenna_01_f": // 78-89
		{
			[78, 89, "military"]; // nearby player
		};
		case "muzzle_antenna_02_f": // 390-500
		{
			[390, 500, "experimental"]; // mission use only
		};
		case "muzzle_antenna_03_f": // 433
		{
			[433, 433, "jammer"]; // drone
		};
		default // what?
		{
			[-1, -1];
		};
	};
	missionNamespace setVariable ["#EM_FMin", _fRange select 0];
	missionNamespace setVariable ["#EM_FMax", _fRange select 1];
	_selRange = [((_fRange select 1) - (_fRange select 0)) / 22, 0] call BIS_fnc_cutDecimals;
	_selCenter = ((_fRange select 1) + (_fRange select 0)) / 2;
	missionNamespace setVariable ["#EM_SelMin", _selCenter - _selRange];
	missionNamespace setVariable ["#EM_SelMax", _selCenter + _selRange];
	missionNamespace setVariable ["#EM_SMin", -80];
	missionNamespace setVariable ["#EM_SMax", -30];
	missionNamespace setVariable ["#EM_Transmit", true];
	missionNamespace setVariable ["#EM_Values", [141.8,-30, 140.85,-50, 141.12,-40]];
};

// https://community.bistudio.com/wiki/Arma_3:_Spectrum_Device