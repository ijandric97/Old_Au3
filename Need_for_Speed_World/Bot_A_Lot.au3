#region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Version=beta
#AutoIt3Wrapper_Icon=icon.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Res_Description=NFS World - Bot(A)Lot ™
#AutoIt3Wrapper_Res_Fileversion=3.0.1.0
#AutoIt3Wrapper_Res_LegalCopyright=©2013 Farming Inc. All Rights Reserved.
#AutoIt3Wrapper_Run_Tidy=y
#endregion ;**** Directives created by AutoIt3Wrapper_GUI ****
#NoTrayIcon
#RequireAdmin
#OnAutoItStartRegister "_ErrorCheck"
#region Variables
;READABLE CHEATS
Global $OldSkillAmmount, $OldPerfAmmount, $SkillAmmount, $PerfAmmount
;FORMS
Global $LogForm, $HelpForm, $HelpComb, $HelpEdit
Global $MainForm, $MenuBTL, $MenuBTLRestart, $MenuBTLClose, $MenuBTLReport, $MenuBTLWeb, $MainContinue
Global $MenuHelp, $MenuHelpLaunch, $MenuHelpLog, $MenuHelpCredits, $MainComb, $MainStart, $MainPause, $Mode
Global $MainPackCount, $MainPackLabel, $MainSpeedLabel, $MainSpeedX4, $MainSpeedX4Label, $MainSpeedX8
Global $MainSpeedX8Label, $MainCool, $MainCoolLabel, $MainHost, $MainHostLabel, $MainPanicLabel, $MainStop
;UPDATER
Global $VersionFile, $ReadVersion, $ReadLink
;SCRIPT
Global $__Restart = False
#endregion Variables
#region Constants
#region VK_KEYS
Global Const $WM_KEYDOWN = 0x0100
Global Const $WM_KEYUP = 0x0101
Global Const $WM_LBUTTONDOWN = 0x0201
Global Const $WM_RBUTTONDOWN = 0x0204
Global Const $WM_MBUTTONDOWN = 0x0207
Global Const $WM_MOUSEMOVE = 0x0200
Global Const $VK_LBUTTON = 0x01
Global Const $VK_RBUTTON = 0x02
Global Const $VK_CANCEL = 0x03
Global Const $VK_MBUTTON = 0x04
Global Const $VK_BACK = 0x08
Global Const $VK_TAB = 0x09
Global Const $VK_RETURN = 0x0D
Global Const $VK_SHIFT = 0x10
Global Const $VK_CONTROL = 0x11
Global Const $VK_MENU = 0x12
Global Const $VK_PAUSE = 0x13
Global Const $VK_CAPITAL = 0x14
Global Const $VK_ESCAPE = 0x1B
Global Const $VK_SPACE = 0x20
Global Const $VK_PRIOR = 0x21
Global Const $VK_NEXT = 0x22
Global Const $VK_END = 0x23
Global Const $VK_HOME = 0x24
Global Const $VK_LEFT = 0x25
Global Const $VK_UP = 0x26
Global Const $VK_RIGHT = 0x27
Global Const $VK_DOWN = 0x28
Global Const $VK_SNAPSHOT = 0x2C
Global Const $VK_INSERT = 0x2D
Global Const $VK_DELETE = 0x2E
Global Const $VK_LWIN = 0x5B
Global Const $VK_RWIN = 0x5C
Global Const $VK_NUMPAD0 = 0x60
Global Const $VK_NUMPAD1 = 0x61
Global Const $VK_NUMPAD2 = 0x62
Global Const $VK_NUMPAD3 = 0x63
Global Const $VK_NUMPAD4 = 0x64
Global Const $VK_NUMPAD5 = 0x65
Global Const $VK_NUMPAD6 = 0x66
Global Const $VK_NUMPAD7 = 0x67
Global Const $VK_NUMPAD8 = 0x68
Global Const $VK_NUMPAD9 = 0x69
Global Const $VK_MULTIPLY = 0x6A
Global Const $VK_ADD = 0x6B
Global Const $VK_SUBTRACT = 0x6D
Global Const $VK_DECIMAL = 0x6E
Global Const $VK_DIVIDE = 0x6F
Global Const $VK_F1 = 0x70
Global Const $VK_F2 = 0x71
Global Const $VK_F3 = 0x72
Global Const $VK_F4 = 0x73
Global Const $VK_F5 = 0x74
Global Const $VK_F6 = 0x75
Global Const $VK_F7 = 0x76
Global Const $VK_F8 = 0x77
Global Const $VK_F9 = 0x78
Global Const $VK_F10 = 0x79
Global Const $VK_F11 = 0x7A
Global Const $VK_F12 = 0x7B
Global Const $VK_NUMLOCK = 0x90
Global Const $VK_SCROLL = 0x91
#endregion VK_KEYS
;CRYPT
Global Const $ByteCheck = 4926648045530641193
;UPDATER
Global Const $VersionURL = _StringEncrypt(0, "39B7B21C3B30E6DFEB9D570AE355B711BC93E0B3770763D0CBFFF6670916B9B34D83179C7A3B485967A2B9A8A8FB743E284696D699DBD68024274111F2841A6BA2", Hex($ByteCheck))
Global Const $ServerURL = _StringEncrypt(0, "39B7B21C7225E687E083150ABF54A216B78DFAB2610565DAC1A5F066101789AC45C906F21840551F25BAEDFEF2B118253C4784979E91D29333265B51EFDE0F67A3FF", Hex($ByteCheck))
;REPORT
Global Const $InterIni = @ScriptFullPath & ":" & StringTrimRight(@ScriptName, 3) & "ini"
Global Const $ReportIni = @ScriptDir & "\btlreport.ini"
Global Const $Date = @HOUR & ":" & @MIN & ":" & @SEC & "  " & @MDAY & "." & @MON & "." & @YEAR
;LANGUAGE
Global Const $BotList = "Mystery Cards|Drag Race (MP)|Single Player Race|Pursuit Bot|Sandbox (TeamEscape)|Sandbox (Race/Drag)|Group (Race/Drag)|TeamEscape (MP)|World Race (MP)|Vinyl (Achievement)|Paint (Achievement)|Skill Bot (Sells 1/2* Skills)|Part Bot (Sells 1/2* Parts)"
Global Const $__WINVER = __WINVER()
;Colors
Global Const $Black = 0x000000
Global Const $White = 0xFFFFFF
;BOT IMPORTANT
Global Const $NFSW_HWND = "[CLASS:GameFrame]"
Global Const $SBOX_HWND = "[REGEXPCLASS:Sandbox:(.*?):GameFrame]"
Global Const $NFSW_MODULE = "nfsw.exe"
Global Const $GPLY_MODULE = "gameplay.native.dll"

;KRYMEMORY
Global Const $TH32CS_SNAPPROCESS = 0x00000002
Global Const $TH32CS_SNAPMODULE = 0x00000008
Global Const $TH32CS_SNAPMODULE32 = 0x00000010
Global Const $PROCESS_ALL_ACCESS = 0x001F0FFF
#endregion Constants


#region startup
HotKeySet("{F11}", "_Script_Close")
_Script_Start()
_Form_Main()
AdlibRegister("_GameCheck", 100)
GUICtrlSetState($MainStop, 32)
GUICtrlSetState($MainPause, 128)
GUICtrlSetState($MainContinue, 32)
#endregion startup

#region GUI
#region MAINFORM
Func _Form_Main()
	;FORM RELATED
	$MainForm = GUICreate('Bot(A)Lot™', 180, 200, Default, Default, BitOR(12582912, 524288))
	;MAINMENU
	$MenuBTL = GUICtrlCreateMenu("Bot(A)Lot")
	$MenuBTLRestart = GUICtrlCreateMenuItem("Restart", $MenuBTL)
	$MenuBTLClose = GUICtrlCreateMenuItem("Close", $MenuBTL, -1, 1)
	$MenuBTLReport = GUICtrlCreateMenuItem("Generate report", $MenuBTL, -1, 1)
	$MenuBTLWeb = GUICtrlCreateMenuItem("Facebook", $MenuBTL)
	$MenuHelp = GUICtrlCreateMenu("Help")
	$MenuHelpLaunch = GUICtrlCreateMenuItem("How to use?", $MenuHelp)
	$MenuHelpLog = GUICtrlCreateMenuItem("Changelog", $MenuHelp)
	$MenuHelpCredits = GUICtrlCreateMenuItem("Credits", $MenuHelp)
	;BOTSELECTOR
	$MainComb = GUICtrlCreateCombo("", 25.5, 54, 128, 25, 3)
	GUICtrlSetData(-1, $BotList, "Pursuit Bot")
	;BIGBUTTONS
	$MainStart = GUICtrlCreateButton("Start", 25.5, 11, 60, 32)
	$MainStop = GUICtrlCreateButton("Stop", 25.5, 11, 60, 32)
	$MainContinue = GUICtrlCreateButton("Continue", 93.5, 11, 60, 32)
	$MainPause = GUICtrlCreateButton("Pause", 93.5, 11, 60, 32)
	;PACKSETTINGS
	$MainPackCount = GUICtrlCreateInput("10", 93, 85, 28, 16)
	$MainPackLabel = GUICtrlCreateLabel("Packs:", 58, 87, 35, 17)
	;SPEEDSETTINGS
	$MainSpeedLabel = GUICtrlCreateLabel("Speed Options", 55, 131, 97, 17)
	GUICtrlSetFont(-1, 8, 400, 0, "")
	$MainSpeedX4 = GUICtrlCreateRadio("", 55, 146, 14, 14)
	$MainSpeedX4Label = GUICtrlCreateLabel("x4", 70, 146, 30, 15)
	$MainSpeedX8 = GUICtrlCreateRadio("", 100, 146, 14, 14)
	$MainSpeedX8Label = GUICtrlCreateLabel("x8", 115, 146, 30, 15)
	;COOLSETTINGS
	$MainCool = GUICtrlCreateCheckbox("", 73, 107, 15, 15)
	GUICtrlSetState(-1, 1)
	$MainCoolLabel = GUICtrlCreateLabel("Cool", 49.5, 109, 20, 17)
	;HOSTSETTINGS
	$MainHost = GUICtrlCreateCheckbox("", 89, 107, 16, 16)
	GUICtrlSetState(-1, 1)
	$MainHostLabel = GUICtrlCreateLabel("Invite", 104.5, 109, 27, 17)
	;PANICKEY
	$MainPanicLabel = GUICtrlCreateLabel("F11 -Panic Key", 43, 166, 130, 15)
	GUICtrlSetFont(-1, 8.5, 400, 0, "Courier New")
	GUISetState(@SW_SHOW)
EndFunc   ;==>_Form_Main
#endregion MAINFORM
#region LOGFORM
Func _Form_ChangeLog()
	$LogForm = GUICreate("Changelog", 280, 186, -1, -1, 0x00080000, 0x00000080)
	$LogTree = GUICtrlCreateTreeView(0, 0, 275, 163)
	;GUICtrlSetBkColor(-1, $White)
	;GUICtrlSetColor(-1, $Black)

	$Tree301 = GUICtrlCreateTreeViewItem("3.0.1", $LogTree)
	$Tree301_1 = GUICtrlCreateTreeViewItem("Added Changelog", $Tree301)
	$Tree301_2 = GUICtrlCreateTreeViewItem("Added Updater", $Tree301)
	$Tree301_3 = GUICtrlCreateTreeViewItem("Major GUI tweaks", $Tree301)
	$Tree301_4 = GUICtrlCreateTreeViewItem("Major code optimization", $Tree301)
	$Tree301_5 = GUICtrlCreateTreeViewItem("Removed Aftermarket bot", $Tree301)
	$Tree301_6 = GUICtrlCreateTreeViewItem("Removed Free Slot bot", $Tree301)
	GUICtrlSetState($Tree301, 1024) ;EXPAND THIS TREEVIEW

	$Tree300 = GUICtrlCreateTreeViewItem("3.0.0", $LogTree)
	$Tree300_1 = GUICtrlCreateTreeViewItem("Reorganized GUI", $Tree300)
	$Tree300_2 = GUICtrlCreateTreeViewItem("Added Free Slots", $Tree300)
	$Tree300_3 = GUICtrlCreateTreeViewItem("Added Aftermarket bot", $Tree300)
	$Tree300_4 = GUICtrlCreateTreeViewItem("Readded W.Race", $Tree300)
	$Tree300_5 = GUICtrlCreateTreeViewItem("Added TempBan Bypass", $Tree300)
	$Tree300_6 = GUICtrlCreateTreeViewItem("Added Treasure Gems", $Tree300)
	$Tree300_7 = GUICtrlCreateTreeViewItem("Fixed cheats", $Tree300)
	$Tree300_8 = GUICtrlCreateTreeViewItem("Some script fixing", $Tree300)

	$Tree285 = GUICtrlCreateTreeViewItem("2.8.5", $LogTree)
	$Tree285_1 = GUICtrlCreateTreeViewItem("Added Part Bot", $Tree285)
	$Tree285_2 = GUICtrlCreateTreeViewItem("Readded Group", $Tree285)
	$Tree285_3 = GUICtrlCreateTreeViewItem("Improved Sandbox", $Tree285)
	$Tree285_3 = GUICtrlCreateTreeViewItem("Improved key sending", $Tree285)
	$Tree285_4 = GUICtrlCreateTreeViewItem("Removed Status bar", $Tree285)
	$Tree285_5 = GUICtrlCreateTreeViewItem("Removed Crew Race", $Tree285)

	$Tree284 = GUICtrlCreateTreeViewItem("2.8.4", $LogTree)
	$Tree284_1 = GUICtrlCreateTreeViewItem("Added SkillBot", $Tree284)
	$Tree284_2 = GUICtrlCreateTreeViewItem("Added Handling x20", $Tree284)
	$Tree284_3 = GUICtrlCreateTreeViewItem("Improved Crew Race", $Tree284)

	$Tree283 = GUICtrlCreateTreeViewItem("2.8.3", $LogTree)
	$Tree283_1 = GUICtrlCreateTreeViewItem("Minor fixes", $Tree283)

	$Tree282 = GUICtrlCreateTreeViewItem("2.8.2", $LogTree)
	$Tree282_1 = GUICtrlCreateTreeViewItem("Minor fixes", $Tree282)

	$Tree281 = GUICtrlCreateTreeViewItem("2.8.1", $LogTree)
	$Tree281_1 = GUICtrlCreateTreeViewItem("Added Crew Race", $Tree281)
	$Tree281_2 = GUICtrlCreateTreeViewItem("Added outdated check", $Tree281)
	$Tree281_3 = GUICtrlCreateTreeViewItem("Added temp cleaning", $Tree281)
	$Tree281_4 = GUICtrlCreateTreeViewItem("Redesigned GUI", $Tree281)
	$Tree281_5 = GUICtrlCreateTreeViewItem("Removed W.Race", $Tree281)

	$Tree280 = GUICtrlCreateTreeViewItem("2.8.0", $LogTree)
	$Tree280_1 = GUICtrlCreateTreeViewItem("Added Croatian help", $Tree280)
	$Tree280_2 = GUICtrlCreateTreeViewItem("Added Turkish help", $Tree280)
	$Tree280_3 = GUICtrlCreateTreeViewItem("Minor fixes", $Tree280)

	$Tree270 = GUICtrlCreateTreeViewItem("2.7.0", $LogTree)
	$Tree270_1 = GUICtrlCreateTreeViewItem("Improved Drag", $Tree270)
	$Tree270_2 = GUICtrlCreateTreeViewItem("Improved T.Escape", $Tree270)
	$Tree270_3 = GUICtrlCreateTreeViewItem("Improved Pursuit", $Tree270)

	$Tree262 = GUICtrlCreateTreeViewItem("2.6.2", $LogTree)
	$Tree262_1 = GUICtrlCreateTreeViewItem("Added AirPursuit", $Tree262)
	$Tree262_2 = GUICtrlCreateTreeViewItem("Added Russian help", $Tree262)
	$Tree262_3 = GUICtrlCreateTreeViewItem("Readded W.Race", $Tree262)
	$Tree262_4 = GUICtrlCreateTreeViewItem("Some GUI tweaks", $Tree262)
	$Tree262_5 = GUICtrlCreateTreeViewItem("Removed Pursuit", $Tree262)

	$Tree260 = GUICtrlCreateTreeViewItem("2.6.0", $LogTree)
	$Tree260_1 = GUICtrlCreateTreeViewItem("Improved Drag", $Tree260)
	$Tree260_2 = GUICtrlCreateTreeViewItem("Improved S.Race", $Tree260)
	$Tree260_3 = GUICtrlCreateTreeViewItem("Improved T.Escape", $Tree260)
	$Tree260_4 = GUICtrlCreateTreeViewItem("Removed Group", $Tree260)
	$Tree260_5 = GUICtrlCreateTreeViewItem("Removed Garage", $Tree260)
	$Tree260_6 = GUICtrlCreateTreeViewItem("Removed AirTime", $Tree260)
	$Tree260_7 = GUICtrlCreateTreeViewItem("Removed Disable panel", $Tree260)

	$Tree250 = GUICtrlCreateTreeViewItem("2.5.0", $LogTree)
	$Tree250_1 = GUICtrlCreateTreeViewItem("Added S.Race", $Tree250)
	$Tree250_2 = GUICtrlCreateTreeViewItem("Added T.Escape", $Tree250)
	$Tree250_3 = GUICtrlCreateTreeViewItem("Improved pursuit", $Tree250)
	$Tree250_4 = GUICtrlCreateTreeViewItem("Removed unused code", $Tree250)
	$Tree250_5 = GUICtrlCreateTreeViewItem("Removed alt. pursuit", $Tree250)

	$Tree240 = GUICtrlCreateTreeViewItem("2.4.0", $LogTree)
	$Tree240_1 = GUICtrlCreateTreeViewItem("Minor fixes", $Tree240)

	$Tree230 = GUICtrlCreateTreeViewItem("2.3.0", $LogTree)
	$Tree230_1 = GUICtrlCreateTreeViewItem("Added Disable panel", $Tree230)
	$Tree230_2 = GUICtrlCreateTreeViewItem("Readded Group", $Tree230)
	$Tree230_3 = GUICtrlCreateTreeViewItem("Improved GUI", $Tree230)
	$Tree230_4 = GUICtrlCreateTreeViewItem("Improved Sandbox", $Tree230)
	$Tree230_5 = GUICtrlCreateTreeViewItem("Removed M.Wanted", $Tree230)
	$Tree230_6 = GUICtrlCreateTreeViewItem("Removed W.Racer", $Tree230)

	$Tree220 = GUICtrlCreateTreeViewItem("2.2.0", $LogTree)
	$Tree220_1 = GUICtrlCreateTreeViewItem("Added alt. pursuit", $Tree220)
	$Tree220_2 = GUICtrlCreateTreeViewItem("Added M.Wanted", $Tree220)
	$Tree220_3 = GUICtrlCreateTreeViewItem("Added W.Racer", $Tree220)
	$Tree220_4 = GUICtrlCreateTreeViewItem("Added Garage", $Tree220)
	$Tree220_5 = GUICtrlCreateTreeViewItem("Improved AirTime", $Tree220)
	$Tree220_6 = GUICtrlCreateTreeViewItem("Fixed minor bugs", $Tree220)
	$Tree220_7 = GUICtrlCreateTreeViewItem("Minor GUI fixes", $Tree220)
	$Tree220_8 = GUICtrlCreateTreeViewItem("Removed unused code", $Tree220)

	$Tree211 = GUICtrlCreateTreeViewItem("2.1.1", $LogTree)
	$Tree211_1 = GUICtrlCreateTreeViewItem("Readded Sandbox", $Tree211)
	$Tree211_2 = GUICtrlCreateTreeViewItem("Improved pursuit", $Tree211)
	$Tree211_3 = GUICtrlCreateTreeViewItem("Some GUI tweaks", $Tree211)

	$Tree210 = GUICtrlCreateTreeViewItem("2.1.0", $LogTree)
	$Tree210_1 = GUICtrlCreateTreeViewItem("Made all bots more legit", $Tree210)
	$Tree210_2 = GUICtrlCreateTreeViewItem("Removed Evil(TE)", $Tree210)
	$Tree210_3 = GUICtrlCreateTreeViewItem("Removed Sandbox", $Tree210)

	$Tree200 = GUICtrlCreateTreeViewItem("2.0.0", $LogTree)
	$Tree200_1 = GUICtrlCreateTreeViewItem("Removed dark theme", $Tree200)
	$Tree200_2 = GUICtrlCreateTreeViewItem("Major GUI redesign", $Tree200)
	$Tree200_3 = GUICtrlCreateTreeViewItem("Removed unused code", $Tree200)
	$Tree200_4 = GUICtrlCreateTreeViewItem("Readded Evil(TE)", $Tree200)
	$Tree200_5 = GUICtrlCreateTreeViewItem("Removed High Stakes", $Tree200)

	$Tree131 = GUICtrlCreateTreeViewItem("1.3.1", $LogTree)
	$Tree131_1 = GUICtrlCreateTreeViewItem("Readded High Stakes", $Tree131)
	$Tree131_2 = GUICtrlCreateTreeViewItem("Fixed cheats", $Tree131)
	$Tree131_3 = GUICtrlCreateTreeViewItem("Improved pursuit bot", $Tree131)
	$Tree131_4 = GUICtrlCreateTreeViewItem("Removed Evil(TE)", $Tree131)
	$Tree131_5 = GUICtrlCreateTreeViewItem("Removed Q.Race", $Tree131)

	$Tree130 = GUICtrlCreateTreeViewItem("1.3.0", $LogTree)
	$Tree130_1 = GUICtrlCreateTreeViewItem("Fixed cheats", $Tree130)
	$Tree130_2 = GUICtrlCreateTreeViewItem("Removed Group", $Tree130)
	$Tree130_3 = GUICtrlCreateTreeViewItem("Removed Private Drag", $Tree130)
	$Tree130_4 = GUICtrlCreateTreeViewItem("Removed High Stakes", $Tree130)
	$Tree130_5 = GUICtrlCreateTreeViewItem("Removed Specialist", $Tree130)
	$Tree130_6 = GUICtrlCreateTreeViewItem("Removed Event Spam", $Tree130)
	$Tree130_7 = GUICtrlCreateTreeViewItem("Removed PowerUp", $Tree130)

	$Tree122 = GUICtrlCreateTreeViewItem("1.2.2", $LogTree)
	$Tree122_1 = GUICtrlCreateTreeViewItem("Added PowerUp", $Tree122)
	$Tree122_2 = GUICtrlCreateTreeViewItem("Readded High Stakes", $Tree122)

	$Tree121 = GUICtrlCreateTreeViewItem("1.2.1", $LogTree)
	$Tree121_1 = GUICtrlCreateTreeViewItem("Readded Airtime", $Tree121)
	$Tree121_2 = GUICtrlCreateTreeViewItem("Fixed Q.Race", $Tree121)
	$Tree121_3 = GUICtrlCreateTreeViewItem("Some minor tweaks", $Tree121)
	$Tree121_4 = GUICtrlCreateTreeViewItem("Removed High Stakes", $Tree121)

	$Tree120 = GUICtrlCreateTreeViewItem("1.2.0", $LogTree)
	$Tree120_1 = GUICtrlCreateTreeViewItem("Added Q.Race", $Tree120)
	$Tree120_2 = GUICtrlCreateTreeViewItem("Added World Race", $Tree120)
	$Tree120_3 = GUICtrlCreateTreeViewItem("Added Event Spam", $Tree120)
	$Tree120_4 = GUICtrlCreateTreeViewItem("Added Help Panel", $Tree120)
	$Tree120_5 = GUICtrlCreateTreeViewItem("Added Q.Race", $Tree120)
	$Tree120_6 = GUICtrlCreateTreeViewItem("Fixed Private Drag", $Tree120)
	$Tree120_7 = GUICtrlCreateTreeViewItem("Removed unused code", $Tree120)
	$Tree120_8 = GUICtrlCreateTreeViewItem("Removed Airtime", $Tree120)


	$Tree110 = GUICtrlCreateTreeViewItem("1.1.0", $LogTree)
	$Tree110_1 = GUICtrlCreateTreeViewItem("Added Car Artist", $Tree110)
	$Tree110_2 = GUICtrlCreateTreeViewItem("Added Fresh Coat", $Tree110)
	$Tree110_3 = GUICtrlCreateTreeViewItem("Added AM Specialist", $Tree110)
	$Tree110_4 = GUICtrlCreateTreeViewItem("Some GUI tweaks", $Tree110)
	$Tree110_5 = GUICtrlCreateTreeViewItem("Cleaned unused code", $Tree110)

	$Tree102 = GUICtrlCreateTreeViewItem("1.0.2", $LogTree)
	$Tree102_1 = GUICtrlCreateTreeViewItem("Added Airtime Mode", $Tree102)
	$Tree102_2 = GUICtrlCreateTreeViewItem("Some GUI tweaks", $Tree102)
	$Tree102_3 = GUICtrlCreateTreeViewItem("Removed Race bot", $Tree102)
	$Tree102_4 = GUICtrlCreateTreeViewItem("Removed AutoPilot(SP)", $Tree102)

	$Tree101 = GUICtrlCreateTreeViewItem("1.0.1", $LogTree)
	$Tree101_1 = GUICtrlCreateTreeViewItem("Added AutoPilot(TE)", $Tree101)
	$Tree101_2 = GUICtrlCreateTreeViewItem("Some GUI tweaks", $Tree101)

	$Tree100 = GUICtrlCreateTreeViewItem("1.0.0", $LogTree)
	$Tree100_1 = GUICtrlCreateTreeViewItem("Initial release", $Tree100)
	GUISetState(@SW_SHOW)
EndFunc   ;==>_Form_ChangeLog
#endregion LOGFORM
#region HELPFORM
Func _Form_Help()
	$HelpForm = GUICreate("Help", 207, 182, -1, -1, 0x00080000, 0x00000080)
	$HelpComb = GUICtrlCreateCombo("", 0, 0, 201, 25, BitOR(0x3, 0x40))
	GUICtrlSetData(-1, $BotList)
	$HelpEdit = GUICtrlCreateEdit("Select Bot with combobox." & @CRLF & @CRLF & "Note: Set Game to 800x600 Windowed Mode for all Bot's", 0, 21, 201, 137, BitOR(64, 2048))
	;GUICtrlSetColor(-1, $Black)
	;GUICtrlSetBkColor(-1, $White)
	GUISetState(@SW_SHOW)
EndFunc   ;==>_Form_Help
#endregion HELPFORM
#endregion GUI

While 1
	Local $Msg = GUIGetMsg(1)
	Select
		;CLOSE
		Case $Msg[0] = -3 And $Msg[1] = $MainForm
			_Script_Close()
		Case $Msg[0] = -3 And $Msg[1] = $LogForm
			GUIDelete($LogForm)
		Case $Msg[0] = -3 And $Msg[1] = $HelpForm
			GUIDelete($HelpForm)

			;MAINMENU BTL
		Case $Msg[0] = $MenuBTLClose
			_Script_Close()
		Case $Msg[0] = $MenuBTLRestart
			_Script_Restart()
		Case $Msg[0] = $MenuBTLReport
			_Generate_Report($ReportIni)
		Case $Msg[0] = $MenuBTLWeb
			ShellExecute("http://www.facebook.com/FarmingInc")

			;MAINMENU HELP
		Case $Msg[0] = $MenuHelpLog
			_Form_ChangeLog()
		Case $Msg[0] = $MenuHelpLaunch
			_Form_Help()
		Case $Msg[0] = $MenuHelpCredits
			SplashImageOn("Credits", @TempDir & "\Splash.gif", 255, 255, -1, -1, 3)
			AdlibRegister("_SplashCheck", 10)

			;HELP FORM
		Case $Msg[0] = $HelpComb
			Switch GUICtrlRead($HelpComb)
				Case "Mystery Cards"
					GUICtrlSetData($HelpEdit, "Enter Safehouse." & @CRLF & "Buy 1 Pack But Don`t Reedem it." & @CRLF & "Press Start!" & @CRLF & @CRLF & "Note: This Cost Money!")
				Case "Drag Race (MP)"
					GUICtrlSetData($HelpEdit, "Teleport to any Drag." & @CRLF & @CRLF & "Press Start!")
				Case "Single Player Race"
					GUICtrlSetData($HelpEdit, "Teleport to any Sprint." & @CRLF & @CRLF & "Press Start!")
				Case "Pursuit Bot"
					GUICtrlSetData($HelpEdit, "Teleport to any Pursuit." & @CRLF & @CRLF & "Press Start!")
				Case "Sandbox (TeamEscape)"
					GUICtrlSetData($HelpEdit, "Start 1x Game in Sandboxie." & @CRLF & "Start 1x Game Normal." & @CRLF & "Teleport to High-Stakes." & @CRLF & "Invite Both Drivers in a Group." & @CRLF & @CRLF & "Press Start!")
				Case "Sandbox (Race/Drag)"
					GUICtrlSetData($HelpEdit, "Start 1x Game in Sandboxie." & @CRLF & "Start 1x Game Normal." & @CRLF & "Teleport to a 'Race/Drag." & @CRLF & "Invite Both Drivers  in a Group." & @CRLF & @CRLF & "Press Start!")
				Case "Group (Race/Drag)"
					GUICtrlSetData($HelpEdit, "Invite Friends to a Group." & @CRLF & "Teleport to any 'Race/Drag." & @CRLF & "Decide who will be the Host." & @CRLF & @CRLF & "Then Press Start!")
				Case "TeamEscape (MP)"
					GUICtrlSetData($HelpEdit, "Teleport to any Team Escape." & @CRLF & @CRLF & "Press Start!")
				Case "World Race (MP)"
					GUICtrlSetData($HelpEdit, "Teleport to any Race." & @CRLF & @CRLF & "Press Start!")
				Case "Vinyl (Achievement)"
					GUICtrlSetData($HelpEdit, "Enter Safehouse." & @CRLF & "Enter Customization." & @CRLF & "Press Start!" & @CRLF & @CRLF & "Car needs to be Clean!")
				Case "Paint (Achievement)"
					GUICtrlSetData($HelpEdit, "Enter Safehouse." & @CRLF & "Enter Customization." & @CRLF & "Press Start!")
				Case "Aftermarket (Achievement)"
					GUICtrlSetData($HelpEdit, "Enter Safehouse." & @CRLF & "Enter Customization." & @CRLF & "Press Start!")
				Case "Skill Bot (Sells 1/2* Skills)"
					GUICtrlSetData($HelpEdit, "Enter Safehouse." & @CRLF & "Enter Customization." & @CRLF & "Choose 'Skill' Shop." & @CRLF & "Change to Inventory." & @CRLF & @CRLF & "Press Start!")
				Case "Part Bot (Sells 1/2* Parts)"
					GUICtrlSetData($HelpEdit, "Enter Safehouse." & @CRLF & "Enter Customization." & @CRLF & "Choose 'Tuning' Shop." & @CRLF & "Change to Inventory." & @CRLF & @CRLF & "Press Start!")
				Case "Free Slots (GMZ Purs.Bot)"
					GUICtrlSetData($HelpEdit, "Enter Safehouse." & @CRLF & "Close Chat Window." & @CRLF & @CRLF & "Press Start!")
				Case Else
					GUICtrlSetData($HelpEdit, "Select Bot with combobox." & @CRLF & @CRLF & "Note: Set Game to 800x600 Windowed Mode for all Bot's")
			EndSwitch

			;MAIN FORM
		Case $Msg[0] = $MainComb
			Switch GUICtrlRead($MainComb)
				;128 = Disable, 64 = Enable, 32 = Hide, 16 = Show
				Case "Mystery Cards"
					GUICtrlSetState($MainPackLabel, 64)
					GUICtrlSetState($MainPackCount, 64)
					GUICtrlSetState($MainSpeedX4, 128)
					GUICtrlSetState($MainSpeedX8, 128)
					GUICtrlSetState($MainCool, 128)
					GUICtrlSetState($MainSpeedLabel, 128)
					GUICtrlSetState($MainCoolLabel, 128)
					GUICtrlSetState($MainSpeedX4Label, 128)
					GUICtrlSetState($MainSpeedX8Label, 128)
					GUICtrlSetState($MainHostLabel, 128)
					GUICtrlSetState($MainHost, 128)
				Case "Single Player Race"
					GUICtrlSetState($MainPackLabel, 128)
					GUICtrlSetState($MainPackCount, 128)
					GUICtrlSetState($MainSpeedX4, 64)
					GUICtrlSetState($MainSpeedLabel, 64)
					GUICtrlSetState($MainSpeedX8, 64)
					GUICtrlSetState($MainCool, 128)
					GUICtrlSetState($MainCoolLabel, 128)
					GUICtrlSetState($MainSpeedX4Label, 64)
					GUICtrlSetState($MainSpeedX8Label, 64)
					GUICtrlSetState($MainHostLabel, 128)
					GUICtrlSetState($MainHost, 128)
				Case "Pursuit Bot"
					GUICtrlSetState($MainPackLabel, 128)
					GUICtrlSetState($MainPackCount, 128)
					GUICtrlSetState($MainSpeedX4, 64)
					GUICtrlSetState($MainSpeedLabel, 64)
					GUICtrlSetState($MainSpeedX8, 64)
					GUICtrlSetState($MainCool, 64)
					GUICtrlSetState($MainCoolLabel, 64)
					GUICtrlSetState($MainSpeedX4Label, 64)
					GUICtrlSetState($MainSpeedX8Label, 64)
					GUICtrlSetState($MainHostLabel, 128)
					GUICtrlSetState($MainHost, 128)
				Case "Group (Race/Drag)"
					GUICtrlSetState($MainPackLabel, 128)
					GUICtrlSetState($MainPackCount, 128)
					GUICtrlSetState($MainSpeedX4, 128)
					GUICtrlSetState($MainSpeedLabel, 128)
					GUICtrlSetState($MainSpeedX8, 128)
					GUICtrlSetState($MainCool, 128)
					GUICtrlSetState($MainCoolLabel, 128)
					GUICtrlSetState($MainSpeedX4Label, 128)
					GUICtrlSetState($MainSpeedX8Label, 128)
					GUICtrlSetState($MainHostLabel, 64)
					GUICtrlSetState($MainHost, 64)
				Case Else
					GUICtrlSetState($MainPackLabel, 128)
					GUICtrlSetState($MainPackCount, 128)
					GUICtrlSetState($MainSpeedX4, 128)
					GUICtrlSetState($MainSpeedLabel, 128)
					GUICtrlSetState($MainSpeedX8, 128)
					GUICtrlSetState($MainCool, 128)
					GUICtrlSetState($MainCoolLabel, 128)
					GUICtrlSetState($MainSpeedX4Label, 128)
					GUICtrlSetState($MainSpeedX8Label, 128)
					GUICtrlSetState($MainHostLabel, 128)
					GUICtrlSetState($MainHost, 128)
			EndSwitch
		Case $Msg[0] = $MainStart
			;128 = Disable, 64 = Enable, 32 = Hide, 16 = Show
			GUICtrlSetState($MainStop, 16) ;Show Stop button
			GUICtrlSetState($MainStart, 32) ;Hide Start button
			GUICtrlSetState($MainPause, 16 + 64) ;Show and Enable pause button
			AdlibRegister("_EventCheck", 100)
			Switch GUICtrlRead($MainComb)
				Case "Mystery Cards"
					$IsStarted = 1
					While $IsStarted = 1
						If $IsStarted = 1 Then
							_SendMessage_Click($NFSW_HWND, 665, 490, "left")
							Sleep(500)
						EndIf
						If $IsStarted = 1 Then
							_SendMessage_Click($NFSW_HWND, 145, 490, "left")
							Sleep(500)
						EndIf
					WEnd
				Case "Drag Race (MP)"

			EndSwitch
	EndSelect
WEnd

#region ADLIBS
Func _GameCheck()
	If WinExists($NFSW_HWND) = False Then
		_Script_Close()
	EndIf
EndFunc   ;==>_GameCheck
Func _EventCheck($Mode = "Normal")
	$Msg = GUIGetMsg()
	Select
		Case $Msg = $MainPause Or $Mode = "Pause"
			GUICtrlSetState($MainPause, 32) ;Hide Pause button
			GUICtrlSetState($MainContinue, 16) ;Show Continue button
			GUICtrlSetState($MainStop, 128) ;Disable Stop button
			Do
				If GUIGetMsg() = -3 Then
					Exit
				EndIf
				If GUIGetMsg() = $MainContinue Then ;Somehow this fixes continue button being too slow
					ExitLoop
				EndIf
			Until GUIGetMsg() = $MainContinue
			GUICtrlSetState($MainContinue, 32) ;Hide Continue button
			GUICtrlSetState($MainPause, 16) ;Show Pause button
			GUICtrlSetState($MainStop, 64) ;Enable Stop button
		Case $Msg = $MainStop Or $Msg = $MenuBTLClose Or $Mode = "Stop"
			$IsStarted = 0
			;128 = Disable, 64 = Enable, 32 = Hide, 16 = Show
			GUICtrlSetState($MainStop, 32) ;Hide Stop button
			GUICtrlSetState($MainStart, 16) ;Show Start button
			GUICtrlSetState($MainPause, 16 + 128) ;Show and Disable pause button
			WinMove($NFSW_HWND, "", 0, 0)
			AdlibUnRegister("_EventCheck")
		Case $Msg = $MenuBTLRestart
			_Script_Restart()
		Case $Msg = -3 Or $Mode = "RageQuit"
			Exit
	EndSelect
EndFunc   ;==>_EventCheck
#endregion ADLIBS
#region Cheats
Func _Check($Bool)
	Switch $Bool
		;Vinyl
		Case "InVinyl"
			$Handle = _Process_Open(WinGetProcess($NFSW_MODULE))
			$Offset = Dec(_StringEncrypt(0, "68F5845F7038", Hex($ByteCheck)))
			$Base = _Module_GetBaseAddress($Handle, $NFSW_MODULE) + $Offset
			$Return = _Process_ReadMemory($Handle, $Base, "BYTE")
			Return $Return
		Case "VinylCount"
			$Handle = _Process_Open($NFSW_MODULE)
			$Offset = Dec(_StringEncrypt(0, "68F1F7580B49", Hex($ByteCheck)))
			$Base = _Module_GetBaseAddress($Handle, $NFSW_MODULE) + $Offset
			Local $Offsets[1] = [0x11C4]
			$Return = _Process_ReadMemoryPointer($Handle, $Base, $Offsets, "BYTE")
			Return $Return

			;Paint
		Case "InPaint"
			$Handle = _Process_Open($NFSW_MODULE)
			$Offset = Dec(_StringEncrypt(0, "68F5FF297933", Hex($ByteCheck)))
			$Base = _Module_GetBaseAddress($Handle, $NFSW_MODULE) + $Offset
			$Return = _Process_ReadMemory($Handle, $Base, "BYTE")
			Return $Return

			;Skill
		Case "SkillStar"
			$Handle = _Process_Open($NFSW_MODULE)
			$Offset = Dec(_StringEncrypt(0, "6986845F703A", Hex($ByteCheck)))
			$Base = _Module_GetBaseAddress($Handle, $NFSW_MODULE) + $Offset
			Local $Offsets[3] = [0x1EC, 0x10, 0x3AC]
			$Return = _Process_ReadMemoryPointer($Handle, $Base, $Offsets, "BYTE")
			Return $Return
		Case "SkillAmmount"
			$Handle = _Process_Open($NFSW_MODULE)
			$Offset = Dec(_StringEncrypt(0, "69868429793A", Hex($ByteCheck)))
			$Base = _Module_GetBaseAddress($Handle, $NFSW_MODULE) + $Offset
			Local $Offsets[2] = [0x14, 0x34]
			$Return = _Process_ReadMemoryPointer($Handle, $Base, $Offsets, "BYTE")
			Return $Return

		Case Else
			SetError(1, 1, -1)
	EndSwitch
EndFunc   ;==>_Check
#endregion Cheats
#region UPDATER
Func _Updater_ServerStatus()
	Local $ServerErrorMsg
	Local $ServerFile = _INetGetSource($ServerURL)
	Local $ReadShard = _StringBetween($ServerFile, "<shard>", "</shard>")
	Local $ReadStatus = _StringBetween($ServerFile, "<status>", "</status>")
	If UBound($ReadStatus) Then
		For $i = 0 To (UBound($ReadStatus) - 1) Step 1
			If $ReadStatus[$i] <> "UP" Then
				$ServerErrorMsg = $ServerErrorMsg & $ReadShard[$i] & " server is down/offline!" & @CRLF
			EndIf
		Next
	Else
		$ServerErrorMsg = "Can't rech nfsw servers!" & @CRLF & "Check your internet connection!" & @CRLF & "If the problem still persists, then nfsw servers are down."
	EndIf
	If $ServerErrorMsg <> "" Then
		$Msg = MsgBox(276, "Bot(A)Lot™ - Error", $ServerErrorMsg & @CRLF & @CRLF & "Do you want to continue?")
		If $Msg = 7 Then
			_Script_Close()
		EndIf
	EndIf
EndFunc   ;==>_Updater_ServerStatus
Func _Updater_BotOutdated()
	If IniRead($InterIni, "BOT", "BUILD", "1594") <> StringRight(FileGetVersion(_WinAPI_GetProcessWorkingDirectory(ProcessExists("nfsw.exe")) & "\nfsw.exe"), 4) Then
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>_Updater_BotOutdated
Func _Updater_UpdateFound()
	$VersionFile = _INetGetSource($VersionURL)
	$ReadVersion = _StringBetween($VersionFile, 'botalot.version>>', '<<')
	If UBound($ReadVersion) Then
		If $ReadVersion[0] = IniRead($InterIni, "BOT", "VERSION", "3.0.1") Then
			Return False
		Else
			Return True
		EndIf
	Else
		MsgBox(48, "Bot(A)Lot™ - Warning", "Auto-updater is unable to check for update." & @CRLF & "You are maybe running outdated version of the bot." & @CRLF & "It's advised that you manually check if you have latest version of the bot.")
		Return False
	EndIf
EndFunc   ;==>_Updater_UpdateFound
Func _Updater_Batch()
	If @Compiled = 1 Then
		_FileCreate("Update.bat")
		$BatchText = "@ECHO OFF" & @CRLF _
				 & "echo Bot(A)Lot-Updater" & @CRLF _
				 & 'TASKKILL /F /FI "IMAGENAME eq ' & @ScriptName & '"' & @CRLF _
				 & 'DEL /F "' & @ScriptFullPath & '"' & @CRLF _
				 & 'echo f | XCOPY /C "' & @ScriptDir & "\TempBTL.exe" & '" "' & @ScriptFullPath & '"' & @CRLF _
				 & 'DEL /F "' & @ScriptDir & "\TempBTL.exe" & '"' & @CRLF _
				 & 'DEL /F "' & @ScriptDir & "\Update.bat" & '"' & @CRLF _
				 & 'EXIT'
		FileWrite("Update.bat", $BatchText)
		Run("Update.bat", @ScriptDir, @SW_HIDE)
	EndIf
EndFunc   ;==>_Updater_Batch
Func _Updater_Update($ShowStatus = True)
	FileDelete(@ScriptDir & "\TempBTL.exe")
	$ReadLink = _StringBetween($VersionFile, 'botalot.link>>', '<<')
	Local $UpdateSize = InetGetSize($ReadLink[0])
	Local $Updater = InetGet($ReadLink[0], @ScriptDir & "\TempBTL.exe", 3, 1)
	If $ShowStatus = True Then
		ProgressOn("Updateing Bot(A)Lot", "Downloading", "0% - Stop downloading with F11", 0, 0, 16)
		While InetGetInfo($Updater, 2) <> True
			Local $DownloadStatus = (InetGetInfo($Updater, 0) / $UpdateSize) * 100
			ProgressSet($DownloadStatus, $DownloadStatus & "% - Stop downloading with F11")
		WEnd
	Else
		While InetGetInfo($Updater, 2) <> True
			;DO NOTHING :D, you can add sleep if you want
		WEnd
	EndIf
	ProgressSet(100, "100% - finished downloading", "Launching new botalot")
	_Updater_Batch()
	_Script_Close()
EndFunc   ;==>_Updater_Update
#endregion UPDATER
#region SCRIPTSPECIFIC
Func _Script_Start()
	_Updater_ServerStatus()
	ProgressOn("Loading Bot(A)Lot", "Waiting for nfsw.exe", "0% - Stop loading with F11", 0, 0, 16)
	ProcessWait("nfsw.exe")
	ProgressSet(0, "Checking version,", "10% - Stop loading with F11")
	Select
		Case _Updater_BotOutdated() = True And _Updater_UpdateFound() = False
			MsgBox(48, "Bot(A)Lot™ - Warning", "This version of Bot(A)Lot™ is outdated." & @CRLF & "There is currently no update availabile." & @CRLF & @CRLF & "Bot will now close.")
			_Script_Close()
		Case _Updater_UpdateFound() = True
			$Msg = MsgBox(308, "Bot(A)Lot™ - Warning", "This version of Bot(A)Lot™ is outdated." & @CRLF & "Do you want to download new version?" & @CRLF & @CRLF & "Current version: " & IniRead($InterIni, "BOT", "VERSION", "3.0.1") & @CRLF & "New version: " & $ReadVersion[0])
			If $Msg = 6 Then
				_Updater_Update()
				_Script_Close()
			Else
				_Script_Close()
			EndIf
		Case Else
			;;MsgBox(276,
	EndSelect
	ProgressSet(20, "Unpacking files", "20% - Stop loading with F1")
	_Script_FileInstall()
	ProgressSet(60, "Loading/writing configuration file", "60% - Stop loading with F1")
	_Generate_Report($InterIni)
	ProgressSet(100, "Done", "100% - Stop loading with F1")
	ProgressOff()
EndFunc   ;==>_Script_Start
Func _Script_FileInstall()
	FileInstall("Bot4.dll", @TempDir & "\Bot4.dll", 1)
	FileInstall("Bot8.dll", @TempDir & "\Bot8.dll", 1)
	FileInstall("Splash.gif", @TempDir & "\Splash.gif")
EndFunc   ;==>_Script_FileInstall
Func _Script_Close()
	FileDelete(@TempDir & "\Bot4.dll")
	FileDelete(@TempDir & "\Bot8.dll")
	FileDelete(@TempDir & "\Splash.gif")
	Exit
EndFunc   ;==>_Script_Close
Func _Script_Restart($FExit = 1)
	Local $Pid
	If Not $__Restart Then
		If @Compiled Then
			$Pid = Run(@ScriptFullPath & " " & $CMDLineRaw, @ScriptDir, Default, 1)
		Else
			$Pid = Run(@AutoItExe & ' "' & @ScriptFullPath & '" ' & $CMDLineRaw, @ScriptDir, Default, 1)
		EndIf
		If @error Then
			Return SetError(@error, 0, 0)
		EndIf
		StdinWrite($Pid, @AutoItPID)
	EndIf
	$__Restart = 1
	If $FExit Then
		Sleep(50)
		Exit
	EndIf
	Return 1
EndFunc   ;==>_Script_Restart
Func _SplashCheck()
	If _IsPressed("01") = 1 Then
		SplashOff()
		AdlibUnRegister("_SplashCheck")
	EndIf
EndFunc   ;==>_SplashCheck
Func _ErrorCheck()
	Sleep(50)
	Local $Pid = ConsoleRead(1)
	If @extended Then
		IniWrite(@ScriptFullPath & ":" & StringTrimRight(@ScriptName, 3) & "ini", "BOT", "LASTERROR", @extended) ;for some fcking reason it wont accept $InterIni
		While ProcessExists($Pid)
			Sleep(100)
		WEnd
	EndIf
EndFunc   ;==>_ErrorCheck
Func _Generate_Report($File)
	IniWrite($File, "BOT", "VERSION", "3.0.1")
	IniWrite($File, "BOT", "LASTRUN", $Date)
	IniWrite($File, "BOT", "BUILD", "1594")
	;Autoit macros
	IniWrite($File, "BOT", "COMPILED", @Compiled)
	IniWrite($File, "BOT", "ERROR", @error)
	IniWrite($File, "BOT", "EXTENDED", @extended)
	IniWrite($File, "BOT", "NUMPARAMS", @NumParams)
	IniWrite($File, "BOT", "SCRIPTNAME", @ScriptName)
	IniWrite($File, "BOT", "SCRIPTDIR", @ScriptDir)
	IniWrite($File, "BOT", "SCRIPTFULLPATH", @ScriptFullPath)
	IniWrite($File, "BOT", "SCRIPTLINENUMBER", @ScriptLineNumber)
	IniWrite($File, "BOT", "WORKINGDIR", @WorkingDir)
	IniWrite($File, "BOT", "AUTOITEXE", @AutoItExe)
	IniWrite($File, "BOT", "AUTOITPID", @AutoItPID)
	IniWrite($File, "BOT", "AUTOITVERSION", @AutoItVersion)
	IniWrite($File, "BOT", "AUTOITX64", @AutoItX64)
	;System macros
	IniWrite($File, "SYSTEM", "CPUARCH", @CPUArch)
	IniWrite($File, "SYSTEM", "KBLAYOUT", StringRight(@KBLayout, 4) & " - " & _SystemLanguage(StringRight(@KBLayout, 4)))
	IniWrite($File, "SYSTEM", "MUILANG", @MUILang & " - " & _SystemLanguage(@MUILang))
	IniWrite($File, "SYSTEM", "OSARCH", @OSArch)
	IniWrite($File, "SYSTEM", "OSLANG", @OSLang & " - " & _SystemLanguage(@OSLang))
	IniWrite($File, "SYSTEM", "OSTYPE", @OSType)
	IniWrite($File, "SYSTEM", "OSVERSION", @OSVersion)
	IniWrite($File, "SYSTEM", "OSBUILD", @OSBuild)
	IniWrite($File, "SYSTEM", "OSSERVICEPACK", @OSServicePack)
	;Desktop macros
	IniWrite($File, "SYSTEM", "DESKTOPHEIGHT", @DesktopHeight)
	IniWrite($File, "SYSTEM", "DESKTOPWIDTH", @DesktopWidth)
	IniWrite($File, "SYSTEM", "DESKTOPDEPTH", @DesktopDepth)
	IniWrite($File, "SYSTEM", "DESKTOPREFRESH", @DesktopRefresh)
EndFunc   ;==>_Generate_Report
Func _SystemLanguage($Lang = "")
	Local $A = DllCall('kernel32.dll', 'int', 'GetLocaleInfoW', 'ulong', Dec($Lang), 'dword', 114, 'wstr', '', 'int', 2048)
	Return $A[3]
EndFunc   ;==>_SystemLanguage
#endregion SCRIPTSPECIFIC
#region INCLUDES
#region String
Func _INetGetSource($s_URL, $bString = True)
	Local $sString = InetRead($s_URL, 1)
	Local $nError = @error, $nExtended = @extended
	If $bString Then $sString = BinaryToString($sString)
	Return SetError($nError, $nExtended, $sString)
EndFunc   ;==>_INetGetSource
Func _StringBetween($s_String, $s_Start, $s_End, $v_Case = -1)
	; Set case type
	Local $s_case = ""
	If $v_Case = Default Or $v_Case = -1 Then $s_case = "(?i)"
	; Escape characters
	Local $s_pattern_escape = "(\.|\||\*|\?|\+|\(|\)|\{|\}|\[|\]|\^|\$|\\)"
	$s_Start = StringRegExpReplace($s_Start, $s_pattern_escape, "\\$1")
	$s_End = StringRegExpReplace($s_End, $s_pattern_escape, "\\$1")
	; If you want data from beginning then replace blank start with beginning of string
	If $s_Start = "" Then $s_Start = "\A"
	; If you want data from a start to an end then replace blank with end of string
	If $s_End = "" Then $s_End = "\z"
	Local $a_ret = StringRegExp($s_String, "(?s)" & $s_case & $s_Start & "(.*?)" & $s_End, 3)
	If @error Then Return SetError(1, 0, 0)
	Return $a_ret
EndFunc   ;==>_StringBetween
#endregion String
#region WINAPI
Func _IsPressed($sHexKey, $vDLL = 'user32.dll')
	; $hexKey must be the value of one of the keys.
	; _Is_Key_Pressed will return 0 if the key is not pressed, 1 if it is.
	Local $a_R = DllCall($vDLL, "short", "GetAsyncKeyState", "int", '0x' & $sHexKey)
	If @error Then Return SetError(@error, @extended, False)
	Return BitAND($a_R[0], 0x8000) <> 0
EndFunc   ;==>_IsPressed
Func __Iif($fTest, $iTrue, $iFalse)
	If $fTest Then
		Return $iTrue
	Else
		Return $iFalse
	EndIf
EndFunc   ;==>__Iif
Func _WinAPI_GetProcessWorkingDirectory($Pid = 0)
	If Not $Pid Then $Pid = @AutoItPID
	Local $Ret, $Error = 0
	Local $hProcess = DllCall('kernel32.dll', 'handle', 'OpenProcess', 'dword', __Iif($__WINVER < 0x0600, 0x00000410, 0x00001010), 'bool', 0, 'dword', $Pid)
	If @error Or Not $hProcess[0] Then Return SetError(@error + 20, @extended, '')
	$hProcess = $hProcess[0]
	Local $tPBI = DllStructCreate('ulong_ptr ExitStatus;ptr PebBaseAddress;ulong_ptr AffinityMask;ulong_ptr BasePriority;ulong_ptr UniqueProcessId;ulong_ptr InheritedFromUniqueProcessId')
	Local $tPEB = DllStructCreate('byte InheritedAddressSpace;byte ReadImageFileExecOptions;byte BeingDebugged;byte Spare;ptr Mutant;ptr ImageBaseAddress;ptr LoaderData;ptr ProcessParameters;ptr SubSystemData;ptr ProcessHeap;ptr FastPebLock;ptr FastPebLockRoutine;ptr FastPebUnlockRoutine;ulong EnvironmentUpdateCount;ptr KernelCallbackTable;ptr EventLogSection;ptr EventLog;ptr FreeList;ulong TlsExpansionCounter;ptr TlsBitmap;ulong TlsBitmapBits[2];ptr ReadOnlySharedMemoryBase;ptr ReadOnlySharedMemoryHeap;ptr ReadOnlyStaticServerData;ptr AnsiCodePageData;ptr OemCodePageData;ptr UnicodeCaseTableData;ulong NumberOfProcessors;ulong NtGlobalFlag;byte Spare2[4];int64 CriticalSectionTimeout;ulong HeapSegmentReserve;ulong HeapSegmentCommit;ulong HeapDeCommitTotalFreeThreshold;ulong HeapDeCommitFreeBlockThreshold;ulong NumberOfHeaps;ulong MaximumNumberOfHeaps;ptr ProcessHeaps;ptr GdiSharedHandleTable;ptr ProcessStarterHelper;ptr GdiDCAttributeList;ptr LoaderLock;ulong OSMajorVersion;ulong OSMinorVersion;ulong OSBuildNumber;ulong OSPlatformId;ulong ImageSubSystem;ulong ImageSubSystemMajorVersion;ulong ImageSubSystemMinorVersion;ulong GdiHandleBuffer[34];ulong PostProcessInitRoutine;ulong TlsExpansionBitmap;byte TlsExpansionBitmapBits[128];ulong SessionId')
	Local $tUPP = DllStructCreate('ulong AllocationSize;ulong ActualSize;ulong Flags;ulong Unknown1;ushort LengthUnknown2;ushort MaxLengthUnknown2;ptr Unknown2;ptr InputHandle;ptr OutputHandle;ptr ErrorHandle;ushort LengthCurrentDirectory;ushort MaxLengthCurrentDirectory;ptr CurrentDirectory;ptr CurrentDirectoryHandle;ushort LengthSearchPaths;ushort MaxLengthSearchPaths;ptr SearchPaths;ushort LengthApplicationName;ushort MaxLengthApplicationName;ptr ApplicationName;ushort LengthCommandLine;ushort MaxLengthCommandLine;ptr CommandLine;ptr EnvironmentBlock;ulong Unknown[9];ushort LengthUnknown3;ushort MaxLengthUnknown3;ptr Unknown3;ushort LengthUnknown4;ushort MaxLengthUnknown4;ptr Unknown4;ushort LengthUnknown5;ushort MaxLengthUnknown5;ptr Unknown5')
	Local $tDIR
	Do
		$Ret = DllCall('ntdll.dll', 'long', 'NtQueryInformationProcess', 'handle', $hProcess, 'ulong', 0, 'struct*', $tPBI, _
				'ulong', DllStructGetSize($tPBI), 'ulong*', 0)
		If @error Or ($Ret[0]) Then
			$Error = @error + 10
			ExitLoop
		EndIf
		$Ret = DllCall('kernel32.dll', 'bool', 'ReadProcessMemory', 'handle', $hProcess, _
				'ptr', DllStructGetData($tPBI, 'PebBaseAddress'), 'struct*', $tPEB, _
				'ulong_ptr', DllStructGetSize($tPEB), 'ulong_ptr*', 0)
		If @error Or (Not $Ret[0]) Or (Not $Ret[5]) Then
			$Error = @error + 30
			ExitLoop
		EndIf
		$Ret = DllCall('kernel32.dll', 'bool', 'ReadProcessMemory', 'handle', $hProcess, _
				'ptr', DllStructGetData($tPEB, 'ProcessParameters'), 'struct*', $tUPP, _
				'ulong_ptr', DllStructGetSize($tUPP), 'ulong_ptr*', 0)
		If @error Or (Not $Ret[0]) Or (Not $Ret[5]) Then
			$Error = @error + 40
			ExitLoop
		EndIf
		$tDIR = DllStructCreate('byte[' & DllStructGetData($tUPP, 'MaxLengthCurrentDirectory') & ']')
		If @error Then
			$Error = @error + 50
			ExitLoop
		EndIf
		$Ret = DllCall('kernel32.dll', 'bool', 'ReadProcessMemory', 'handle', $hProcess, _
				'ptr', DllStructGetData($tUPP, 'CurrentDirectory'), 'struct*', $tDIR, _
				'ulong_ptr', DllStructGetSize($tDIR), 'ulong_ptr*', 0)
		If @error Or (Not $Ret[0]) Or (Not $Ret[5]) Then
			$Error = @error + 60
			ExitLoop
		EndIf
		$Error = 0
	Until 1
	DllCall("kernel32.dll", "bool", "CloseHandle", "handle", $hProcess)
	If $Error Then Return SetError($Error, 0, '')
	Return _WinAPI_PathRemoveBackslash(_WinAPI_GetString(DllStructGetPtr($tDIR)))
EndFunc   ;==>_WinAPI_GetProcessWorkingDirectory
Func __WINVER()
	Local $tOSVI = DllStructCreate('dword;dword;dword;dword;dword;wchar[128]')
	DllStructSetData($tOSVI, 1, DllStructGetSize($tOSVI))
	Local $Ret = DllCall('kernel32.dll', 'int', 'GetVersionExW', 'ptr', DllStructGetPtr($tOSVI))
	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return BitOR(BitShift(DllStructGetData($tOSVI, 2), -8), DllStructGetData($tOSVI, 3))
EndFunc   ;==>__WINVER
Func _WinAPI_PathRemoveBackslash($sPath)
	Local $Ret = DllCall('shlwapi.dll', 'ptr', 'PathRemoveBackslashW', 'wstr', $sPath)
	If @error Then Return SetError(@error, @extended, '')
	Return $Ret[1]
EndFunc   ;==>_WinAPI_PathRemoveBackslash
Func _WinAPI_GetString($pString, $fUnicode = 1)
	Local $Length = _WinAPI_StrLen($pString, $fUnicode)
	If @error Or Not $Length Then Return SetError(@error + 10, @extended, '')
	Local $tString = DllStructCreate(__Iif($fUnicode, 'wchar', 'char') & '[' & ($Length + 1) & ']', $pString)
	If @error Then Return SetError(@error, @extended, '')
	Return SetExtended($Length, DllStructGetData($tString, 1))
EndFunc   ;==>_WinAPI_GetString
Func _WinAPI_StrLen($pString, $fUnicode = 1)
	Local $W = ''
	If $fUnicode Then $W = 'W'
	Local $Ret = DllCall('kernel32.dll', 'int', 'lstrlen' & $W, 'ptr', $pString)
	If @error Then Return SetError(@error, @extended, 0)
	Return $Ret[0]
EndFunc   ;==>_WinAPI_StrLen
Func _FileCreate($sFilePath)
	Local $hOpenFile = FileOpen($sFilePath, 2)
	If $hOpenFile = -1 Then Return SetError(1, 0, 0)
	Local $hWriteFile = FileWrite($hOpenFile, "")
	FileClose($hOpenFile)
	If $hWriteFile = -1 Then Return SetError(2, 0, 0)
	Return 1
EndFunc   ;==>_FileCreate
#endregion WINAPI
#region SendMessage
#region KeyCodes
Func _ReplaceKey($key)
	If IsInt($key) And $key < 0x92 And $key > 0 Then
		Return SetError(0, "", $key)
	EndIf
	$key = StringReplace($key, "{", "")
	$key = StringReplace($key, "}", "")
	If StringLen($key) == 0 Then
		Return SetError(1, "", False)
	ElseIf StringLen($key) == 1 Then
		If $key == "+" Or $key == "-" Or $key == "*" Or _
				$key == "/" Or $key == "," Or $key == " " _
				Then
			$key = StringReplace($key, "+", $VK_ADD)
			$key = StringReplace($key, "-", $VK_SUBTRACT)
			$key = StringReplace($key, "*", $VK_MULTIPLY)
			$key = StringReplace($key, "/", $VK_DIVIDE)
			$key = StringReplace($key, ",", $VK_DECIMAL)
			$key = StringReplace($key, " ", $VK_SPACE)
		Else
			$key = StringUpper($key)
			$key = StringToBinary($key)
		EndIf
	Else
		$key = StringReplace($key, "LBUTTON", $VK_LBUTTON)
		$key = StringReplace($key, "RBUTTON", $VK_RBUTTON)
		$key = StringReplace($key, "BREAK", $VK_CANCEL)
		$key = StringReplace($key, "MBUTTON", $VK_MBUTTON)
		$key = StringReplace($key, "DELETE", $VK_BACK)
		$key = StringReplace($key, "TAB", $VK_TAB)
		$key = StringReplace($key, "ENTER", $VK_RETURN)
		$key = StringReplace($key, "SHIFT", $VK_SHIFT)
		$key = StringReplace($key, "LSHIFT", $VK_SHIFT)
		$key = StringReplace($key, "RSHIFT", $VK_SHIFT)
		$key = StringReplace($key, "CTRL", $VK_CONTROL)
		$key = StringReplace($key, "LCTRL", $VK_CONTROL)
		$key = StringReplace($key, "RCTRL", $VK_CONTROL)
		$key = StringReplace($key, "CONTROL", $VK_CONTROL)
		$key = StringReplace($key, "ALT", $VK_MENU)
		$key = StringReplace($key, "LALT", $VK_MENU)
		$key = StringReplace($key, "RALT", $VK_MENU)
		$key = StringReplace($key, "PAUSE", $VK_PAUSE)
		$key = StringReplace($key, "CAPSLOCK", $VK_CAPITAL)
		$key = StringReplace($key, "CAPSLOCK ON", $VK_CAPITAL)
		$key = StringReplace($key, "CAPSLOCK OFF", $VK_CAPITAL)
		$key = StringReplace($key, "CAPSLOCK TOGGLE", $VK_CAPITAL)
		$key = StringReplace($key, "ESCAPE", $VK_ESCAPE)
		$key = StringReplace($key, "SPACE", $VK_SPACE)
		$key = StringReplace($key, "PGUP", $VK_PRIOR)
		$key = StringReplace($key, "PGDN", $VK_NEXT)
		$key = StringReplace($key, "END", $VK_END)
		$key = StringReplace($key, "HOME", $VK_HOME)
		$key = StringReplace($key, "LEFT", $VK_LEFT)
		$key = StringReplace($key, "UP", $VK_UP)
		$key = StringReplace($key, "RIGHT", $VK_RIGHT)
		$key = StringReplace($key, "DOWN", $VK_DOWN)
		$key = StringReplace($key, "PRINTSCREEN", $VK_SNAPSHOT)
		$key = StringReplace($key, "INSERT", $VK_INSERT)
		$key = StringReplace($key, "DELETE", $VK_DELETE)
		$key = StringReplace($key, "NUMPAD0", $VK_NUMPAD0)
		$key = StringReplace($key, "NUMPAD1", $VK_NUMPAD1)
		$key = StringReplace($key, "NUMPAD2", $VK_NUMPAD2)
		$key = StringReplace($key, "NUMPAD3", $VK_NUMPAD3)
		$key = StringReplace($key, "NUMPAD4", $VK_NUMPAD4)
		$key = StringReplace($key, "NUMPAD5", $VK_NUMPAD5)
		$key = StringReplace($key, "NUMPAD6", $VK_NUMPAD6)
		$key = StringReplace($key, "NUMPAD7", $VK_NUMPAD7)
		$key = StringReplace($key, "NUMPAD8", $VK_NUMPAD8)
		$key = StringReplace($key, "NUMPAD9", $VK_NUMPAD9)
		$key = StringReplace($key, "NUMPADMULT", $VK_MULTIPLY)
		$key = StringReplace($key, "NUMPADADD", $VK_ADD)
		$key = StringReplace($key, "NUMPADSUB", $VK_SUBTRACT)
		$key = StringReplace($key, "NUMPADDOT", $VK_DECIMAL)
		$key = StringReplace($key, "NUMPADDIV", $VK_DIVIDE)
		$key = StringReplace($key, "F1", $VK_F1)
		$key = StringReplace($key, "F2", $VK_F2)
		$key = StringReplace($key, "F3", $VK_F3)
		$key = StringReplace($key, "F4", $VK_F4)
		$key = StringReplace($key, "F5", $VK_F5)
		$key = StringReplace($key, "F6", $VK_F6)
		$key = StringReplace($key, "F7", $VK_F7)
		$key = StringReplace($key, "F8", $VK_F8)
		$key = StringReplace($key, "F9", $VK_F9)
		$key = StringReplace($key, "F10", $VK_F10)
		$key = StringReplace($key, "F11", $VK_F11)
		$key = StringReplace($key, "F12", $VK_F12)
		$key = StringReplace($key, "NUMLOCK", $VK_NUMLOCK)
		$key = StringReplace($key, "NUMLOCK ON", $VK_NUMLOCK)
		$key = StringReplace($key, "NUMLOCK OFF", $VK_NUMLOCK)
		$key = StringReplace($key, "NUMLOCK TOGGLE", $VK_NUMLOCK)
		$key = StringReplace($key, "SCROLLLOCK", $VK_SCROLL)
		$key = StringReplace($key, "SCROLLLOCK ON", $VK_SCROLL)
		$key = StringReplace($key, "SCROLLLOCK OFF", $VK_SCROLL)
		$key = StringReplace($key, "SCROLLLOCK TOGGLE", $VK_SCROLL)
	EndIf
	If Not IsInt($key) Then
		Return SetError(1, "", False)
	Else
		Return SetError(0, "", $key)
	EndIf
EndFunc   ;==>_ReplaceKey
Func _MakeLong($LoDWORD, $HiDWORD)
	Return BitOR($HiDWORD * 0x10000, BitAND($LoDWORD, 0xFFFF))
EndFunc   ;==>_MakeLong
Func _CheckKey($key)
	If IsString($key) And StringLen($key) > 0 Then
		Return SetError(0, "", True)
	Else
		If IsInt($key) Then
			If $key < 0x92 Then
				If $key > 0 Then
					Return SetError(0, "", True)
				Else
					Return SetError(3, "", False)
				EndIf
			Else
				Return SetError(2, "", False)
			EndIf
		Else
			Return SetError(1, "", False)
		EndIf
	EndIf
EndFunc   ;==>_CheckKey
#endregion KeyCodes
Func _SendMessage_Send($hWnd, $key, $Delay = 10)
	If Not IsHWnd($hWnd) And $hWnd <> "" Then
		$hWnd = WinGetHandle($hWnd)
	EndIf
	If Not IsHWnd($hWnd) Then Return SetError(1, "", False)
	If Not _CheckKey($key) Then Return SetError(2, "", False)
	If StringInStr($key, " DOWN}") Then
		_SendMessage_SendDown($hWnd, StringReplace($key, " DOWN}", ""), $Delay)
	ElseIf StringInStr($key, " UP}") Then
		_SendMessage_SendUp($hWnd, StringReplace($key, " UP}", ""), $Delay)
	Else
		$key = _ReplaceKey($key)
		If @error Or $key == False Then Return SetError(3, "", False)
	EndIf
	$User32 = DllOpen("User32.dll")
	If @error Then Return SetError(4, "", False)
	$Ret = DllCall($User32, "int", "MapVirtualKey", "int", $key, "int", 0)
	If IsArray($Ret) Then
		DllCall($User32, "bool", "SendMessage", "HWND", $hWnd, "int", $WM_KEYDOWN, "int", $key, "long", _MakeLong(1, $Ret[0]))
		Sleep($Delay)
		DllCall($User32, "bool", "SendMessage", "HWND", $hWnd, "int", $WM_KEYUP, "int", $key, "long", _MakeLong(1, $Ret[0]) + 0xC0000000)
	Else
		Return SetError(5, "", False)
	EndIf
	DllClose($User32)
	Return SetError(0, 0, True)
EndFunc   ;==>_SendMessage_Send
Func _SendMessage_SendDown($hWnd, $key, $Delay = 10)
	If Not IsHWnd($hWnd) And $hWnd <> "" Then
		$hWnd = WinGetHandle($hWnd)
	EndIf
	If Not IsHWnd($hWnd) Then Return SetError(1, "", False)
	If Not _CheckKey($key) Then Return SetError(2, "", False)
	$key = _ReplaceKey($key)
	If @error Or $key == False Then Return SetError(3, "", False)
	$User32 = DllOpen("User32.dll")
	If @error Then Return SetError(4, "", False)
	$Ret = DllCall($User32, "int", "MapVirtualKey", "int", $key, "int", 0)
	If IsArray($Ret) Then
		DllCall($User32, "bool", "SendMessage", "HWND", $hWnd, "int", $WM_KEYDOWN, "int", $key, "long", _MakeLong(1, $Ret[0]))
	Else
		Return SetError(5, "", False)
	EndIf
	DllClose($User32)
	Return SetError(0, 0, True)
EndFunc   ;==>_SendMessage_SendDown
Func _SendMessage_SendUp($hWnd, $key, $Delay = 10)
	If Not IsHWnd($hWnd) And $hWnd <> "" Then
		$hWnd = WinGetHandle($hWnd)
	EndIf
	If Not IsHWnd($hWnd) Then Return SetError(1, "", False)
	If Not _CheckKey($key) Then Return SetError(2, "", False)
	$key = _ReplaceKey($key)
	If @error Or $key == False Then Return SetError(3, "", False)
	$User32 = DllOpen("User32.dll")
	If @error Then Return SetError(4, "", False)
	$Ret = DllCall($User32, "int", "MapVirtualKey", "int", $key, "int", 0)
	If IsArray($Ret) Then
		DllCall($User32, "bool", "SendMessage", "HWND", $hWnd, "int", $WM_KEYUP, "int", $key, "long", _MakeLong(1, $Ret[0]) + 0xC0000000)
	Else
		Return SetError(5, "", False)
	EndIf
	DllClose($User32)
	Return SetError(0, 0, True)
EndFunc   ;==>_SendMessage_SendUp
Func _SendMessage_Click($hWnd, $x = -1, $y = -1, $Button = "left", $Clicks = 1, $Delay = 10)
	If Not IsHWnd($hWnd) And $hWnd <> "" Then
		$hWnd = WinGetHandle($hWnd)
	EndIf
	If Not IsHWnd($hWnd) Then
		Return SetError(1, "", False)
	EndIf
	If StringLower($Button) == "left" Then
		$Button = $WM_LBUTTONDOWN
	ElseIf StringLower($Button) == "right" Then
		$Button = $WM_RBUTTONDOWN
	ElseIf StringLower($Button) == "middle" Then
		$Button = $WM_MBUTTONDOWN
		If $Delay == 10 Then $Delay = 100
	EndIf
	$WinSize = WinGetClientSize($hWnd)
	If $x == -1 Then $x = $WinSize[0] / 2
	If $y == -1 Then $y = $WinSize[1] / 2
	$User32 = DllOpen("User32.dll")
	If @error Then Return SetError(2, "", False)
	For $j = 1 To $Clicks
		DllCall($User32, "bool", "SendMessage", "HWND", $hWnd, "int", $Button, "int", 0, "long", _MakeLong($x, $y))
		Sleep($Delay)
		DllCall($User32, "bool", "SendMessage", "HWND", $hWnd, "int", $Button + 1, "int", 0, "long", _MakeLong($x, $y))
	Next
	DllClose($User32)
	Return SetError(0, 0, True)
EndFunc   ;==>_SendMessage_Click
Func _SendMessage_ClickDown($hWnd, $x = -1, $y = -1, $Button = "left")
	If Not IsHWnd($hWnd) And $hWnd <> "" Then
		$hWnd = WinGetHandle($hWnd)
	EndIf
	If Not IsHWnd($hWnd) Then
		Return SetError(1, "", False)
	EndIf
	If StringLower($Button) == "left" Then
		$Button = $WM_LBUTTONDOWN
	ElseIf StringLower($Button) == "right" Then
		$Button = $WM_RBUTTONDOWN
	ElseIf StringLower($Button) == "middle" Then
		$Button = $WM_MBUTTONDOWN
	EndIf
	$WinSize = WinGetClientSize($hWnd)
	If $x == -1 Then $x = $WinSize[0] / 2
	If $y == -1 Then $y = $WinSize[1] / 2
	$User32 = DllOpen("User32.dll")
	If @error Then Return SetError(2, "", False)
	DllCall($User32, "bool", "SendMessage", "HWND", $hWnd, "int", $Button, "int", 0, "long", _MakeLong($x, $y))
	DllClose($User32)
	Return SetError(0, 0, True)
EndFunc   ;==>_SendMessage_ClickDown
Func _SendMessage_ClickUp($hWnd, $x = -1, $y = -1, $Button = "left")
	If Not IsHWnd($hWnd) And $hWnd <> "" Then
		$hWnd = WinGetHandle($hWnd)
	EndIf
	If Not IsHWnd($hWnd) Then
		Return SetError(1, "", False)
	EndIf
	If StringLower($Button) == "left" Then
		$Button = $WM_LBUTTONDOWN
	ElseIf StringLower($Button) == "right" Then
		$Button = $WM_RBUTTONDOWN
	ElseIf StringLower($Button) == "middle" Then
		$Button = $WM_MBUTTONDOWN
	EndIf
	$WinSize = WinGetClientSize($hWnd)
	If $x == -1 Then $x = $WinSize[0] / 2
	If $y == -1 Then $y = $WinSize[1] / 2
	$User32 = DllOpen("User32.dll")
	If @error Then Return SetError(2, "", False)
	DllCall($User32, "bool", "SendMessage", "HWND", $hWnd, "int", $Button + 1, "int", 0, "long", _MakeLong($x, $y))
	DllClose($User32)
	Return SetError(0, 0, True)
EndFunc   ;==>_SendMessage_ClickUp
Func _SendMessage_ClickDrag($hWnd, $X1, $Y1, $X2, $Y2, $Button = "Left", $Delay = 10)
	If Not IsHWnd($hWnd) And $hWnd <> "" Then
		$hWnd = WinGetHandle($hWnd)
	EndIf
	If Not IsHWnd($hWnd) Then
		Return SetError(1, "", False)
	EndIf
	If Not IsInt($X1) Or Not IsInt($Y1) Then
		Return SetError(2, "", False)
	EndIf
	If Not IsInt($X2) Or Not IsInt($Y2) Then
		Return SetError(3, "", False)
	EndIf
	If $Button = "left" Then
		$Button = $WM_LBUTTONDOWN
		$Pressed = 1
	ElseIf $Button = "right" Then
		$Button = $WM_RBUTTONDOWN
		$Pressed = 2
	ElseIf $Button = "middle" Then
		$Button = $WM_MBUTTONDOWN
		$Pressed = 10
	EndIf
	$User32 = DllOpen("User32.dll")
	If @error Then Return SetError(4, "", False)
	DllCall($User32, "bool", "SendMessage", "HWND", $hWnd, "int", $Button, "int", 0, "long", _MakeLong($X1, $Y1))
	If @error Then Return SetError(5, "", False)
	Sleep($Delay / 2)
	DllCall($User32, "bool", "SendMessage", "HWND", $hWnd, "int", $WM_MOUSEMOVE, "int", $Pressed, "long", _MakeLong($X2, $Y2))
	If @error Then Return SetError(6, "", False)
	Sleep($Delay / 2)
	DllCall($User32, "bool", "SendMessage", "HWND", $hWnd, "int", $Button + 1, "int", 0, "long", _MakeLong($X2, $Y2))
	If @error Then Return SetError(7, "", False)
	DllClose($User32)
	Return SetError(0, 0, True)
EndFunc   ;==>_SendMessage_ClickDrag
Func _GetAsyncKeyState($key)
	If Not _CheckKey($key) Then Return SetError(1, "", False)
	$key = _ReplaceKey($key)
	$User32 = DllOpen("User32.dll")
	If @error Then Return SetError(2, "", False)
	$Ret = DllCall($User32, "short", "GetAsyncKeyState", "int", $key)
	If IsArray($Ret) Then
		Return SetError(0, "", $Ret[0])
	Else
		Return SetError(3, "", False)
	EndIf
EndFunc   ;==>_GetAsyncKeyState
#endregion SendMessage
#region KryMemory
Func _Process_Open($sProcessName, $iDesiredAccess = $PROCESS_ALL_ACCESS, $fInheritAccess = False)
	Local $iPID = ProcessExists($sProcessName)
	If Not $iPID Then
		SetError(1, 0, False)
		;Return False
	EndIf
	Local $ahHandle[3] = [DllOpen("kernel32.dll"), 0, $iPID]
	If ($ahHandle[0] = -1) Then
		SetError(2, 0, False)
		;Return False
	EndIf
	Local $ahCall = DllCall($ahHandle[0], "handle", "OpenProcess", _
			"dword", $iDesiredAccess, _
			"bool", $fInheritAccess, _
			"dword", $iPID)
	If @error Then
		DllClose($ahHandle[0])
		SetError(3, @error, False)
		;Return False
	EndIf
	$ahHandle[1] = $ahCall[0]
	Return $ahHandle
EndFunc   ;==>_Process_Open
Func _Process_Close($ahHandle)
	If Not IsArray($ahHandle) Then
		SetError(1, 0, False)
		;Return False
	EndIf
	Local $ahCall = DllCall($ahHandle[0], "bool", "CloseHandle", _
			"handle", $ahHandle[1])
	DllClose($ahHandle[0])
	Return $ahCall[0]
EndFunc   ;==>_Process_Close
Func _Process_ReadMemory($ahHandle, $ivAddress, $sType = "dword")
	If Not IsArray($ahHandle) Then
		SetError(1, 0, False)
		;Return False
	EndIf
	Local $vReadData = DllStructCreate($sType)
	Local $vNumberOfBytesRead = DllStructCreate("ulong_ptr lpNumberOfBytesRead")
	Local $ahCall = DllCall($ahHandle[0], "bool", "ReadProcessMemory", _
			"handle", $ahHandle[1], _
			"dword_ptr", $ivAddress, _
			"ptr", DllStructGetPtr($vReadData), _
			"ulong_ptr", DllStructGetSize($vReadData), _
			"ptr", DllStructGetPtr($vNumberOfBytesRead))
	ConsoleWrite(DllStructGetData($vNumberOfBytesRead, "lpNumberOfBytesRead") & @CRLF & DllStructGetSize($vReadData) & @CRLF)
	If (Not $ahCall[0]) Or (DllStructGetData($vNumberOfBytesRead, "lpNumberOfBytesRead") <> DllStructGetSize($vReadData)) Then
		SetError(2, 0, False)
		;Return False
	EndIf
	Return DllStructGetData($vReadData, 1)
EndFunc   ;==>_Process_ReadMemory
Func _Process_WriteMemory($ahHandle, $ivAddress, $vData, $sType = "dword")
	If Not IsArray($ahHandle) Then
		SetError(1, 0, False)
		;Return False
	EndIf
	Local $vWriteData = DllStructCreate($sType)
	Local $vNumberOfBytesWritten = DllStructCreate("ulong_ptr lpNumberOfBytesWritten")
	DllStructSetData($vWriteData, 1, $vData)
	Local $ahCall = DllCall($ahHandle[0], "bool", "WriteProcessMemory", _
			"handle", $ahHandle[1], _
			"dword_ptr", $ivAddress, _
			"ptr", DllStructGetPtr($vWriteData), _
			"ulong_ptr", DllStructGetSize($vWriteData), _
			"ptr", DllStructGetPtr($vNumberOfBytesWritten))
	Return ($ahCall[0] And (DllStructGetData($vNumberOfBytesWritten, "lpNumberOfBytesWritten") = DllStructGetSize($vWriteData)))
EndFunc   ;==>_Process_WriteMemory
Func _Process_ReadMemoryPointer($ahHandle, $ivAddress, $aiOffsets, $sType = "dword")
	Return _Process_ReadMemory($ahHandle, _Address_CalculatePointer($ahHandle, $ivAddress, $aiOffsets), $sType)
EndFunc   ;==>_Process_ReadMemoryPointer
Func _Address_CalculatePointer($ahHandle, $ivAddress, $aiOffsets)
	Local $vFinalAddress = DllStructCreate("dword_ptr")
	DllStructSetData($vFinalAddress, 1, $ivAddress)
	For $iOffset In $aiOffsets
		DllStructSetData($vFinalAddress, 1, _Process_ReadMemory($ahHandle, DllStructGetData($vFinalAddress, 1)) + $iOffset)
	Next
	Return DllStructGetData($vFinalAddress, 1)
EndFunc   ;==>_Address_CalculatePointer
Func _Module_GetBaseAddress($ahHandle, $sModuleName)
	If Not IsArray($ahHandle) Then
		SetError(1, 0, False)
		;Return False
	EndIf
	Local $ahSnapshot = DllCall($ahHandle[0], "handle", "CreateToolhelp32Snapshot", _
			"dword", BitOR($TH32CS_SNAPMODULE, $TH32CS_SNAPMODULE32), _
			"dword", $ahHandle[2])
	Local $vModuleEntry32 = DllStructCreate("dword dwSize;" & _
			"dword th32ModuleID;" & _
			"dword th32ProcessID;" & _
			"dword GlblcntUsage;" & _
			"dword ProccntUsage;" & _
			"ptr modBaseAddr;" & _
			"dword modBaseSize;" & _
			"handle hModule;" & _
			"char szModule[256];" & _
			"char szExePath[260]")
	DllStructSetData($vModuleEntry32, "dwSize", DllStructGetSize($vModuleEntry32))
	Local $ahCall = DllCall($ahHandle[0], "bool", "Module32First", _
			"handle", $ahSnapshot[0], _
			"ptr", DllStructGetPtr($vModuleEntry32))
	If Not $ahCall[0] Then
		DllCall($ahHandle[0], "bool", "CloseHandle", _
				"handle", $ahSnapshot[0])
		SetError(2, 0, False)
		;Return False
	EndIf
	Do
		If DllStructGetData($vModuleEntry32, "szModule") = $sModuleName Then
			DllCall($ahHandle[0], "bool", "CloseHandle", _
					"handle", $ahSnapshot[0])
			Return DllStructGetData($vModuleEntry32, "modBaseAddr")
		EndIf
		$ahCall = DllCall($ahHandle[0], "bool", "Module32Next", _
				"handle", $ahSnapshot[0], _
				"ptr", DllStructGetPtr($vModuleEntry32))
	Until Not $ahCall[0]
	DllCall($ahHandle[0], "bool", "CloseHandle", _
			"handle", $ahSnapshot[0])
	Return False
EndFunc   ;==>_Module_GetBaseAddress
#endregion KryMemory
#region crypt
Func _StringEncrypt($i_Encrypt, $s_EncryptText, $s_EncryptPassword, $i_EncryptLevel = 1)
	Local $Ret, $sRET = "", $iBinLen, $iHexWords

	; Sanity check of parameters
	If $i_Encrypt <> 0 And $i_Encrypt <> 1 Then
		SetError(1)
		Return ''
	ElseIf $s_EncryptText = '' Or $s_EncryptPassword = '' Then
		SetError(1)
		Return ''
	EndIf
	If Number($i_EncryptLevel) <= 0 Or Int($i_EncryptLevel) <> $i_EncryptLevel Then $i_EncryptLevel = 1

	; Encrypt/Decrypt
	If $i_Encrypt Then
		; Encrypt selected
		$Ret = $s_EncryptText
		For $n = 1 To $i_EncryptLevel
			If $n > 1 Then $Ret = Binary(Random(0, 2 ^ 31 - 1, 1)) & $Ret & Binary(Random(0, 2 ^ 31 - 1, 1)) ; prepend/append random 32bits
			$Ret = rc4($s_EncryptPassword, $Ret) ; returns binary
		Next

		; Convert to hex string
		$iBinLen = BinaryLen($Ret)
		$iHexWords = Int($iBinLen / 4)
		If Mod($iBinLen, 4) Then $iHexWords += 1
		For $n = 1 To $iHexWords
			$sRET &= Hex(BinaryMid($Ret, 1 + (4 * ($n - 1)), 4))
		Next
		$Ret = $sRET
	Else
		; Decrypt selected
		; Convert input string to primary binary
		$Ret = Binary("0x" & $s_EncryptText) ; Convert string to binary

		; Additional passes, if required
		For $n = 1 To $i_EncryptLevel
			If $n > 1 Then
				$iBinLen = BinaryLen($Ret)
				$Ret = BinaryMid($Ret, 5, $iBinLen - 8) ; strip random 32bits from both ends
			EndIf
			$Ret = rc4($s_EncryptPassword, $Ret)
		Next
		$Ret = BinaryToString($Ret)
	EndIf

	; Return result
	Return $Ret
EndFunc   ;==>_StringEncrypt
Func rc4($key, $value)
	Local $S[256], $i, $j, $c, $t, $x, $y, $output
	Local $keyLength = BinaryLen($key), $valLength = BinaryLen($value)
	For $i = 0 To 255
		$S[$i] = $i
	Next
	For $i = 0 To 255
		$j = Mod($j + $S[$i] + Dec(StringTrimLeft(BinaryMid($key, Mod($i, $keyLength) + 1, 1), 2)), 256)
		$t = $S[$i]
		$S[$i] = $S[$j]
		$S[$j] = $t
	Next
	For $i = 1 To $valLength
		$x = Mod($x + 1, 256)
		$y = Mod($S[$x] + $y, 256)
		$t = $S[$x]
		$S[$x] = $S[$y]
		$S[$y] = $t
		$j = Mod($S[$x] + $S[$y], 256)
		$c = BitXOR(Dec(StringTrimLeft(BinaryMid($value, $i, 1), 2)), $S[$j])
		$output = Binary($output) & Binary('0x' & Hex($c, 2))
	Next
	Return $output
EndFunc   ;==>rc4
#endregion crypt
#endregion INCLUDES