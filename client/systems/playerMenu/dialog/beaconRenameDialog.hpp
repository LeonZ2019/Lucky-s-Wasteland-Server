class BeaconRenameDialog
{
	idd = 3666;
	movingEnable = true;
	enableSimulation = true;
	onLoad = "uiNamespace setVariable ['beaconRename', _this select 0]";

	class ControlsBackground
	{
		class RenameMainBG: IGUIBack
		{
			idc = -1;
			colorBackground[] = {0, 0, 0, 0.6};
			moving = true;

			#define RenameMainBG_W ((0.42 * X_SCALE) min safezoneW)
			#define RenameMainBG_H ((0.18 * Y_SCALE) min safezoneH)
			#define RenameMainBG_X (CENTER(1, RenameMainBG_W) max safezoneX)
			#define RenameMainBG_Y (CENTER(1, RenameMainBG_H) max safezoneY)

			x = RenameMainBG_X;
			y = RenameMainBG_Y;
			w = RenameMainBG_W;
			h = RenameMainBG_H;
		};
		class RenameTitleBar: IGUIBack
		{
			idc = -1;
			colorText[] = {1, 1, 1, 1};
			colorBackground[] = {A3W_UICOLOR_R, A3W_UICOLOR_G, A3W_UICOLOR_B, 0.8};

			#define RenameTopBar_W RenameMainBG_W
			#define RenameTopBar_H (0.04 * Y_SCALE)
			#define RenameTopBar_X RenameMainBG_X
			#define RenameTopBar_Y RenameMainBG_Y

			x = RenameTopBar_X;
			y = RenameTopBar_Y;
			w = RenameTopBar_W;
			h = RenameTopBar_H;
		};
		class RenameText: w_RscText
		{
			idc = -1;
			text = "SPAWN BEACON RENAME";
			sizeEx = 0.06 * TEXT_SCALE;

			#define RenameMenuTitle_W (0.32 * X_SCALE)
			#define RenameMenuTitle_H (0.12 * Y_SCALE)
			#define RenameEditBox_X (RenameMainBG_X + CENTER(RenameTopBar_W, RenameMenuTitle_W))
			#define RenameEditBox_Y (RenameMainBG_Y + CENTER(RenameTopBar_H, RenameMenuTitle_H))

			x = RenameEditBox_X;
			y = RenameEditBox_Y;
			w = RenameMenuTitle_W;
			h = RenameMenuTitle_H;
		};
		class RenameBox: w_RscEdit
		{
			idc = 3667;
			maxChars = 25;
			style = "16 + 512";
			sizeEx = 0.04 * TEXT_SCALE;
			colorBackground[] = {0, 0, 0, 0.6};
			colorDisabled[] = {1,1,1,0.25};

			#define RenameEditBox_W (0.29 * X_SCALE)
			#define RenameEditBox_H (0.04 * Y_SCALE)
			#define RenameMenuTitle_X (RenameMainBG_X + CENTER(RenameMainBG_W, RenameEditBox_W))
			#define RenameMenuTitle_Y (RenameMainBG_Y + CENTER(RenameMainBG_H, RenameEditBox_H))
			//#define RenameMenuTitle_X (0.21 * X_SCALE)
			//#define RenameMenuTitle_Y (0.23 * Y_SCALE)

			x = RenameMenuTitle_X;
			y = RenameMenuTitle_Y;
			w = RenameEditBox_W;
			h = RenameEditBox_H;
		};

		class cancelButton: w_RscButton
		{
			#define RenameButton_W (0.15 * X_SCALE)
			#define RenameButton_H (0.04 * Y_SCALE)
			#define RenameCancel_X (RenameMainBG_X + (RenameMainBG_W / 2) - RenameButton_W * 1.25)
			#define RenameCancel_Y (0.125 * Y_SCALE + RenameMainBG_Y)

			idc = -1;
			text = "Cancel";
			action = "closeDialog 0";
			x = RenameCancel_X;
			y = RenameCancel_Y;
			w = RenameButton_W;
			h = RenameButton_H;
		};

		class okButton: w_RscButton
		{
			//#define RenameOK_X (0.195 * X_SCALE + RenameMainBG_X)
			#define RenameOK_X (RenameMainBG_X + (RenameMainBG_W / 2) + (RenameButton_W * 0.25))
			// #define RenameOK_Y (0.15 * Y_SCALE + RenameMainBG_Y)

			idc = -1;
			text = "Confirm";
			action = "[] execVM 'client\items\beacon\rename.sqf';";
			x = RenameOK_X;
			y = RenameCancel_Y;
			w = RenameButton_W;
			h = RenameButton_H;
		};
	};
};
