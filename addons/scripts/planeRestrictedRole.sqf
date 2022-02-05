// Notes Copilot
// VTOL_02 Gunner gunner (vehicle player)
// VTOL_01 Copilot (vehicle player) turretUnit [0]

pilotOnly = [
	"Plane_CAS_01_base_F",
	"Plane_CAS_02_base_F",
	"VTOL_01_base_F",
	"VTOL_02_base_F",
	"Plane_Fighter_01_Base_F",
	"Plane_Fighter_02_Base_F",
	"Plane_Fighter_03_base_F",
	"Plane_Fighter_04_Base_F"
];

pilotGroundVehicles = [
	"Static_Designator_01_base_F",
	"Kart_01_Base_F",
	"Tractor_01_base_F",
	"Quadbike_01_base_F",
	"Hatchback_01_base_F",
	"SUV_01_base_F",
	"Offroad_02_base_F",
	"Offroad_01_unarmed_base_F",
	"Van_01_base_F",
	"Van_02_base_F",
	"Truck_01_base_F",
	"Truck_02_base_F",
	"Truck_03_base_F",
	"LSV_01_light_base_F",
	"LSV_01_unarmed_base_F",
	"LSV_02_unarmed_base_F",
	"MRAP_01_base_F",
	"MRAP_02_base_F",
	"MRAP_03_base_F",
	"LT_01_scout_base_F",
	"LT_01_cannon_base_F",
	"B_APC_Tracked_01_CRV_F",
	"B_APC_Tracked_01_rcws_F",
	"APC_Tracked_03_base_F",
	"O_APC_Tracked_02_cannon_F"
];

waitUntil {["playerSetupComplete", false] call getPublicVar};

_isPilotRole = ["_Pilot_", typeOf player] call fn_findString != -1;

while {true} do
{
	waitUntil {sleep 0.25; vehicle player != player && vehicle player isKindOf "Plane"}; // better fps fix
	_veh = vehicle player;
	_vehClass = typeOf _veh;
	if (!_isPilotRole) then
	{
		if (pilotOnly findIf {_vehClass isKindOf _x} != -1) then
		{
			if (driver _veh == player) then
			{
				["Pilot seat for pilot only, use pilot role instead", 5] call mf_notify_client;
				moveOut player; // is safe to move out? let him be
			};
			if (currentPilot _veh == player && ["VTOL_01_base_F", "VTOL_02_base_F"] findIf {_vehClass isKindOf _x} != -1) then
			{
				["You can't take control of this aircraft, use pilot role instead", 5] call mf_notify_client;
				player action ["SuspendVehicleControl", (vehicle player)];
			};
		};
	} else
	{
		if (pilotGroundVehicles findIf {_vehClass isKindOf _x} != -1) then
		{
			moveOut player;
			["You can't get in this vehicle, use other role instead", 5] call mf_notify_client;
		};
	};
};
