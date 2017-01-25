#NoTrayIcon
#RequireAdmin
#region
#AutoIt3Wrapper_Version=beta
#AutoIt3Wrapper_Icon=icon.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Res_Description=NFS World - Bot(A)Lot ™
#AutoIt3Wrapper_Res_Fileversion=3.0.1.0
#AutoIt3Wrapper_Res_LegalCopyright=©2013 Farming Inc. All Rights Reserved.
#AutoIt3Wrapper_Run_Tidy=y
#endregion
#region Wrapper
#endregion Wrapper
#OnAutoItStartRegister "_ErrorCheck"
#region Variables
Global $MAINFORM, $LOGFORM, $HELPFORM, $HELPCOMB, $HELPEDIT
Global $VERSIONFILE, $READVERSION, $READLINK
Global $__RESTART = False
#endregion Variables
#region Constants
Global Const $GUI_CHECKED = 1
Global Const $INI = @ScriptFullPath & ":" & StringTrimRight(@ScriptName, 3) & "ini"
Global Const $REPORTINI = @ScriptDir & "\btlreport.ini"
Global Const $VERSIONURL = "https://dl.dropboxusercontent.com/u/222117377/Current/version.txt"
Global Const $DATE = @HOUR & ":" & @MIN & ":" & @SEC & "  " & @MDAY & "." & @MON & "." & @YEAR
Global Const $BOTLIST = "Mystery Cards|Drag Race (MP)|Single Player Race|Pursuit Bot|Sandbox (TeamEscape)|Sandbox (Race/Drag)|Group (Race/Drag)|TeamEscape (MP)|World Race (MP)|Vinyl (Achievement)|Paint (Achievement)|Aftermarket (Achievement)|Skill Bot (Sells 1/2* Skills)|Part Bot (Sells 1/2* Parts)|Free Slots (GMZ Purs.Bot)"
Global Const $__WINVER = __WINVER()
Global Const $BLACK = 0
Global Const $WHITE = 16777215
#endregion Constants
#region startup
ConsoleWrite(@ScriptName)
_SCRIPT_START()
IniWrite($INI, "BOT", "VERSION", "3.0.1")
IniWrite($INI, "BOT", "LASTRUN", $DATE)
IniWrite($INI, "GAME", "BUILD", "1594")
IniWrite($INI, "SYSTEM", "ARCH", @OSArch)
IniWrite($INI, "SYSTEM", "BUILD", @OSBuild)
IniWrite($INI, "SYSTEM", "LANG", _SYSTEMLANGUAGE(@OSLang))
IniWrite($INI, "SYSTEM", "SPACK", @OSServicePack)
IniWrite($INI, "SYSTEM", "TYPE", @OSType)
IniWrite($INI, "SYSTEM", "VERSION", @OSVersion)
IniWrite($INI, "SYSTEM", "CPUARCH", @CPUArch)
IniWrite($INI, "SYSTEM", "DHEIGHT", @DesktopHeight)
IniWrite($INI, "SYSTEM", "DWIDTH", @DesktopWidth)
#endregion startup
#region GUI
#region MAINFORM
$MAINFORM = GUICreate("Bot(A)Lot™", 180, 200, Default, Default, BitOR(12582912, 524288))
$MENUBTL = GUICtrlCreateMenu("Bot(A)Lot")
$MENUBTLRESTART = GUICtrlCreateMenuItem("Restart", $MENUBTL)
$MENUBTLCLOSE = GUICtrlCreateMenuItem("Close", $MENUBTL, -1, 1)
$MENUBTLREPORT = GUICtrlCreateMenuItem("Generate report", $MENUBTL, -1, 1)
$MENUBTLWEB = GUICtrlCreateMenuItem("Facebook", $MENUBTL)
$MENUHELP = GUICtrlCreateMenu("Help")
$MENUHELPLAUNCH = GUICtrlCreateMenuItem("How to use?", $MENUHELP)
$MENUHELPLOG = GUICtrlCreateMenuItem("Changelog", $MENUHELP)
$MENUHELPCREDITS = GUICtrlCreateMenuItem("Credits", $MENUHELP)
$MAINCOMB = GUICtrlCreateCombo("", 25.5, 54, 128, 25, 3)
GUICtrlSetData(-1, $BOTLIST, "Pursuit Bot")
$MAINSTART = GUICtrlCreateButton("Start", 25.5, 11, 60, 32)
$MAINGEMS = GUICtrlCreateButton("Gems", 93.5, 11, 60, 32)
$MAINPACKCOUNT = GUICtrlCreateInput("10", 93, 85, 28, 16)
$MAINPACKLABEL = GUICtrlCreateLabel("Packs:", 58, 87, 35, 17)
$MAINSPEEDLABEL = GUICtrlCreateLabel("Speed Options", 55, 131, 97, 17)
GUICtrlSetFont(-1, 8, 400, 0, "")
$MAINSPEEDX4 = GUICtrlCreateRadio("", 55, 146, 14, 14)
$MAINSPEEDX4LABEL = GUICtrlCreateLabel("x4", 70, 146, 30, 15)
$MAINSPEEDX8 = GUICtrlCreateRadio("", 100, 146, 14, 14)
$MAINSPEEDX8LABEL = GUICtrlCreateLabel("x8", 115, 146, 30, 15)
$MAINCOOL = GUICtrlCreateCheckbox("", 73, 107, 15, 15)
GUICtrlSetState(-1, $GUI_CHECKED)
$MAINCOOLLABEL = GUICtrlCreateLabel("Cool", 49.5, 109, 20, 17)
$MAINHOST = GUICtrlCreateCheckbox("", 89, 107, 16, 16)
GUICtrlSetState(-1, $GUI_CHECKED)
$MAINHOSTLABEL = GUICtrlCreateLabel("Invite", 104.5, 109, 27, 17)
$MAINPANICLABEL = GUICtrlCreateLabel("F11 -Panic Key", 43, 166, 130, 15)
GUICtrlSetFont(-1, 8.5, 400, 0, "Courier New")
GUISetState(@SW_SHOW)
#endregion MAINFORM
#region LOGFORM
Func _CHANGELOG()
	$LOGFORM = GUICreate("Changelog", 280, 186, -1, -1, 524288, 128)
	$LOGTREE = GUICtrlCreateTreeView(0, 0, 275, 163)
	$TREE301 = GUICtrlCreateTreeViewItem("3.0.1", $LOGTREE)
	$TREE301_1 = GUICtrlCreateTreeViewItem("Added Changelog", $TREE301)
	$TREE301_2 = GUICtrlCreateTreeViewItem("Major GUI tweaks", $TREE301)
	$TREE301_3 = GUICtrlCreateTreeViewItem("Major code optimization", $TREE301)
	GUICtrlSetState($TREE301, 1024)
	$TREE300 = GUICtrlCreateTreeViewItem("3.0.0", $LOGTREE)
	$TREE300_1 = GUICtrlCreateTreeViewItem("Reorganized GUI", $TREE300)
	$TREE300_2 = GUICtrlCreateTreeViewItem("Added Free Slots", $TREE300)
	$TREE300_3 = GUICtrlCreateTreeViewItem("Added Aftermarket bot", $TREE300)
	$TREE300_4 = GUICtrlCreateTreeViewItem("Readded W.Race", $TREE300)
	$TREE300_5 = GUICtrlCreateTreeViewItem("Added TempBan Bypass", $TREE300)
	$TREE300_6 = GUICtrlCreateTreeViewItem("Added Treasure Gems", $TREE300)
	$TREE300_7 = GUICtrlCreateTreeViewItem("Fixed cheats", $TREE300)
	$TREE300_8 = GUICtrlCreateTreeViewItem("Some script fixing", $TREE300)
	$TREE285 = GUICtrlCreateTreeViewItem("2.8.5", $LOGTREE)
	$TREE285_1 = GUICtrlCreateTreeViewItem("Added Part Bot", $TREE285)
	$TREE285_2 = GUICtrlCreateTreeViewItem("Readded Group", $TREE285)
	$TREE285_3 = GUICtrlCreateTreeViewItem("Improved Sandbox", $TREE285)
	$TREE285_3 = GUICtrlCreateTreeViewItem("Improved key sending", $TREE285)
	$TREE285_4 = GUICtrlCreateTreeViewItem("Removed Status bar", $TREE285)
	$TREE285_5 = GUICtrlCreateTreeViewItem("Removed Crew Race", $TREE285)
	$TREE284 = GUICtrlCreateTreeViewItem("2.8.4", $LOGTREE)
	$TREE284_1 = GUICtrlCreateTreeViewItem("Added SkillBot", $TREE284)
	$TREE284_2 = GUICtrlCreateTreeViewItem("Added Handling x20", $TREE284)
	$TREE284_3 = GUICtrlCreateTreeViewItem("Improved Crew Race", $TREE284)
	$TREE283 = GUICtrlCreateTreeViewItem("2.8.3", $LOGTREE)
	$TREE283_1 = GUICtrlCreateTreeViewItem("Minor fixes", $TREE283)
	$TREE282 = GUICtrlCreateTreeViewItem("2.8.2", $LOGTREE)
	$TREE282_1 = GUICtrlCreateTreeViewItem("Minor fixes", $TREE282)
	$TREE281 = GUICtrlCreateTreeViewItem("2.8.1", $LOGTREE)
	$TREE281_1 = GUICtrlCreateTreeViewItem("Added Crew Race", $TREE281)
	$TREE281_2 = GUICtrlCreateTreeViewItem("Added outdated check", $TREE281)
	$TREE281_3 = GUICtrlCreateTreeViewItem("Added temp cleaning", $TREE281)
	$TREE281_4 = GUICtrlCreateTreeViewItem("Redesigned GUI", $TREE281)
	$TREE281_5 = GUICtrlCreateTreeViewItem("Removed W.Race", $TREE281)
	$TREE280 = GUICtrlCreateTreeViewItem("2.8.0", $LOGTREE)
	$TREE280_1 = GUICtrlCreateTreeViewItem("Added Croatian help", $TREE280)
	$TREE280_2 = GUICtrlCreateTreeViewItem("Added Turkish help", $TREE280)
	$TREE280_3 = GUICtrlCreateTreeViewItem("Minor fixes", $TREE280)
	$TREE270 = GUICtrlCreateTreeViewItem("2.7.0", $LOGTREE)
	$TREE270_1 = GUICtrlCreateTreeViewItem("Improved Drag", $TREE270)
	$TREE270_2 = GUICtrlCreateTreeViewItem("Improved T.Escape", $TREE270)
	$TREE270_3 = GUICtrlCreateTreeViewItem("Improved Pursuit", $TREE270)
	$TREE262 = GUICtrlCreateTreeViewItem("2.6.2", $LOGTREE)
	$TREE262_1 = GUICtrlCreateTreeViewItem("Added AirPursuit", $TREE262)
	$TREE262_2 = GUICtrlCreateTreeViewItem("Added Russian help", $TREE262)
	$TREE262_3 = GUICtrlCreateTreeViewItem("Readded W.Race", $TREE262)
	$TREE262_4 = GUICtrlCreateTreeViewItem("Some GUI tweaks", $TREE262)
	$TREE262_5 = GUICtrlCreateTreeViewItem("Removed Pursuit", $TREE262)
	$TREE260 = GUICtrlCreateTreeViewItem("2.6.0", $LOGTREE)
	$TREE260_1 = GUICtrlCreateTreeViewItem("Improved Drag", $TREE260)
	$TREE260_2 = GUICtrlCreateTreeViewItem("Improved S.Race", $TREE260)
	$TREE260_3 = GUICtrlCreateTreeViewItem("Improved T.Escape", $TREE260)
	$TREE260_4 = GUICtrlCreateTreeViewItem("Removed Group", $TREE260)
	$TREE260_5 = GUICtrlCreateTreeViewItem("Removed Garage", $TREE260)
	$TREE260_6 = GUICtrlCreateTreeViewItem("Removed AirTime", $TREE260)
	$TREE260_7 = GUICtrlCreateTreeViewItem("Removed Disable panel", $TREE260)
	$TREE250 = GUICtrlCreateTreeViewItem("2.5.0", $LOGTREE)
	$TREE250_1 = GUICtrlCreateTreeViewItem("Added S.Race", $TREE250)
	$TREE250_2 = GUICtrlCreateTreeViewItem("Added T.Escape", $TREE250)
	$TREE250_3 = GUICtrlCreateTreeViewItem("Improved pursuit", $TREE250)
	$TREE250_4 = GUICtrlCreateTreeViewItem("Removed unused code", $TREE250)
	$TREE250_5 = GUICtrlCreateTreeViewItem("Removed alt. pursuit", $TREE250)
	$TREE240 = GUICtrlCreateTreeViewItem("2.4.0", $LOGTREE)
	$TREE240_1 = GUICtrlCreateTreeViewItem("Minor fixes", $TREE240)
	$TREE230 = GUICtrlCreateTreeViewItem("2.3.0", $LOGTREE)
	$TREE230_1 = GUICtrlCreateTreeViewItem("Added Disable panel", $TREE230)
	$TREE230_2 = GUICtrlCreateTreeViewItem("Readded Group", $TREE230)
	$TREE230_3 = GUICtrlCreateTreeViewItem("Improved GUI", $TREE230)
	$TREE230_4 = GUICtrlCreateTreeViewItem("Improved Sandbox", $TREE230)
	$TREE230_5 = GUICtrlCreateTreeViewItem("Removed M.Wanted", $TREE230)
	$TREE230_6 = GUICtrlCreateTreeViewItem("Removed W.Racer", $TREE230)
	$TREE220 = GUICtrlCreateTreeViewItem("2.2.0", $LOGTREE)
	$TREE220_1 = GUICtrlCreateTreeViewItem("Added alt. pursuit", $TREE220)
	$TREE220_2 = GUICtrlCreateTreeViewItem("Added M.Wanted", $TREE220)
	$TREE220_3 = GUICtrlCreateTreeViewItem("Added W.Racer", $TREE220)
	$TREE220_4 = GUICtrlCreateTreeViewItem("Added Garage", $TREE220)
	$TREE220_5 = GUICtrlCreateTreeViewItem("Improved AirTime", $TREE220)
	$TREE220_6 = GUICtrlCreateTreeViewItem("Fixed minor bugs", $TREE220)
	$TREE220_7 = GUICtrlCreateTreeViewItem("Minor GUI fixes", $TREE220)
	$TREE220_8 = GUICtrlCreateTreeViewItem("Removed unused code", $TREE220)
	$TREE211 = GUICtrlCreateTreeViewItem("2.1.1", $LOGTREE)
	$TREE211_1 = GUICtrlCreateTreeViewItem("Readded Sandbox", $TREE211)
	$TREE211_2 = GUICtrlCreateTreeViewItem("Improved pursuit", $TREE211)
	$TREE211_3 = GUICtrlCreateTreeViewItem("Some GUI tweaks", $TREE211)
	$TREE210 = GUICtrlCreateTreeViewItem("2.1.0", $LOGTREE)
	$TREE210_1 = GUICtrlCreateTreeViewItem("Made all bots more legit", $TREE210)
	$TREE210_2 = GUICtrlCreateTreeViewItem("Removed Evil(TE)", $TREE210)
	$TREE210_3 = GUICtrlCreateTreeViewItem("Removed Sandbox", $TREE210)
	$TREE200 = GUICtrlCreateTreeViewItem("2.0.0", $LOGTREE)
	$TREE200_1 = GUICtrlCreateTreeViewItem("Removed dark theme", $TREE200)
	$TREE200_2 = GUICtrlCreateTreeViewItem("Major GUI redesign", $TREE200)
	$TREE200_3 = GUICtrlCreateTreeViewItem("Removed unused code", $TREE200)
	$TREE200_4 = GUICtrlCreateTreeViewItem("Readded Evil(TE)", $TREE200)
	$TREE200_5 = GUICtrlCreateTreeViewItem("Removed High Stakes", $TREE200)
	$TREE131 = GUICtrlCreateTreeViewItem("1.3.1", $LOGTREE)
	$TREE131_1 = GUICtrlCreateTreeViewItem("Readded High Stakes", $TREE131)
	$TREE131_2 = GUICtrlCreateTreeViewItem("Fixed cheats", $TREE131)
	$TREE131_3 = GUICtrlCreateTreeViewItem("Improved pursuit bot", $TREE131)
	$TREE131_4 = GUICtrlCreateTreeViewItem("Removed Evil(TE)", $TREE131)
	$TREE131_5 = GUICtrlCreateTreeViewItem("Removed Q.Race", $TREE131)
	$TREE130 = GUICtrlCreateTreeViewItem("1.3.0", $LOGTREE)
	$TREE130_1 = GUICtrlCreateTreeViewItem("Fixed cheats", $TREE130)
	$TREE130_2 = GUICtrlCreateTreeViewItem("Removed Group", $TREE130)
	$TREE130_3 = GUICtrlCreateTreeViewItem("Removed Private Drag", $TREE130)
	$TREE130_4 = GUICtrlCreateTreeViewItem("Removed High Stakes", $TREE130)
	$TREE130_5 = GUICtrlCreateTreeViewItem("Removed Specialist", $TREE130)
	$TREE130_6 = GUICtrlCreateTreeViewItem("Removed Event Spam", $TREE130)
	$TREE130_7 = GUICtrlCreateTreeViewItem("Removed PowerUp", $TREE130)
	$TREE122 = GUICtrlCreateTreeViewItem("1.2.2", $LOGTREE)
	$TREE122_1 = GUICtrlCreateTreeViewItem("Added PowerUp", $TREE122)
	$TREE122_2 = GUICtrlCreateTreeViewItem("Readded High Stakes", $TREE122)
	$TREE121 = GUICtrlCreateTreeViewItem("1.2.1", $LOGTREE)
	$TREE121_1 = GUICtrlCreateTreeViewItem("Readded Airtime", $TREE121)
	$TREE121_2 = GUICtrlCreateTreeViewItem("Fixed Q.Race", $TREE121)
	$TREE121_3 = GUICtrlCreateTreeViewItem("Some minor tweaks", $TREE121)
	$TREE121_4 = GUICtrlCreateTreeViewItem("Removed High Stakes", $TREE121)
	$TREE120 = GUICtrlCreateTreeViewItem("1.2.0", $LOGTREE)
	$TREE120_1 = GUICtrlCreateTreeViewItem("Added Q.Race", $TREE120)
	$TREE120_2 = GUICtrlCreateTreeViewItem("Added World Race", $TREE120)
	$TREE120_3 = GUICtrlCreateTreeViewItem("Added Event Spam", $TREE120)
	$TREE120_4 = GUICtrlCreateTreeViewItem("Added Help Panel", $TREE120)
	$TREE120_5 = GUICtrlCreateTreeViewItem("Added Q.Race", $TREE120)
	$TREE120_6 = GUICtrlCreateTreeViewItem("Fixed Private Drag", $TREE120)
	$TREE120_7 = GUICtrlCreateTreeViewItem("Removed unused code", $TREE120)
	$TREE120_8 = GUICtrlCreateTreeViewItem("Removed Airtime", $TREE120)
	$TREE110 = GUICtrlCreateTreeViewItem("1.1.0", $LOGTREE)
	$TREE110_1 = GUICtrlCreateTreeViewItem("Added Car Artist", $TREE110)
	$TREE110_2 = GUICtrlCreateTreeViewItem("Added Fresh Coat", $TREE110)
	$TREE110_3 = GUICtrlCreateTreeViewItem("Added AM Specialist", $TREE110)
	$TREE110_4 = GUICtrlCreateTreeViewItem("Some GUI tweaks", $TREE110)
	$TREE110_5 = GUICtrlCreateTreeViewItem("Cleaned unused code", $TREE110)
	$TREE102 = GUICtrlCreateTreeViewItem("1.0.2", $LOGTREE)
	$TREE102_1 = GUICtrlCreateTreeViewItem("Added Airtime Mode", $TREE102)
	$TREE102_2 = GUICtrlCreateTreeViewItem("Some GUI tweaks", $TREE102)
	$TREE102_3 = GUICtrlCreateTreeViewItem("Removed Race bot", $TREE102)
	$TREE102_4 = GUICtrlCreateTreeViewItem("Removed AutoPilot(SP)", $TREE102)
	$TREE101 = GUICtrlCreateTreeViewItem("1.0.1", $LOGTREE)
	$TREE101_1 = GUICtrlCreateTreeViewItem("Added AutoPilot(TE)", $TREE101)
	$TREE101_2 = GUICtrlCreateTreeViewItem("Some GUI tweaks", $TREE101)
	$TREE100 = GUICtrlCreateTreeViewItem("1.0.0", $LOGTREE)
	$TREE100_1 = GUICtrlCreateTreeViewItem("Initial release", $TREE100)
	GUISetState(@SW_SHOW)
EndFunc
#endregion LOGFORM
#region HELPFORM
Func _HELP()
	$HELPFORM = GUICreate("Help", 207, 182, -1, -1, 524288, 128)
	$HELPCOMB = GUICtrlCreateCombo("", 0, 0, 201, 25, BitOR(3, 64))
	GUICtrlSetData(-1, $BOTLIST)
	$HELPEDIT = GUICtrlCreateEdit("Select Bot with combobox." & @CRLF & @CRLF & "Note: Set Game to 800x600 Windowed Mode for all Bot's", 0, 21, 201, 137, BitOR(64, 2048))
	GUISetState(@SW_SHOW)
EndFunc
#endregion HELPFORM
#endregion GUI
While 1
	Local $MSG = GUIGetMsg(1)
	Select
		Case $MSG[0] = -3 And $MSG[1] = $MAINFORM
			_SCRIPT_CLOSE()
		Case $MSG[0] = -3 And $MSG[1] = $LOGFORM
			GUIDelete($LOGFORM)
		Case $MSG[0] = -3 And $MSG[1] = $HELPFORM
			GUIDelete($HELPFORM)
		Case $MSG[0] = $MENUBTLCLOSE
			_SCRIPT_CLOSE()
		Case $MSG[0] = $MENUBTLRESTART
			_SCRIPT_RESTART()
		Case $MSG[0] = $MENUBTLREPORT
			_CREATEREPORT()
		Case $MSG[0] = $MENUBTLWEB
			ShellExecute("http://www.facebook.com/FarmingInc")
		Case $MSG[0] = $MENUHELPLOG
			_CHANGELOG()
		Case $MSG[0] = $MENUHELPLAUNCH
			_HELP()
		Case $MSG[0] = $MENUHELPCREDITS
			SplashImageOn("Credits", @TempDir & "\Splash.gif", 255, 255, -1, -1, 3)
			AdlibRegister("_SplashCheck", 10)
		Case $MSG[0] = $HELPCOMB
			Switch GUICtrlRead($HELPCOMB)
				Case "Mystery Cards"
					GUICtrlSetData($HELPEDIT, "Enter Safehouse." & @CRLF & "Buy 1 Pack But Don`t Reedem it." & @CRLF & "Press Start!" & @CRLF & @CRLF & "Note: This Cost Money!")
				Case "Drag Race (MP)"
					GUICtrlSetData($HELPEDIT, "Teleport to any Drag." & @CRLF & @CRLF & "Press Start!")
				Case "Single Player Race"
					GUICtrlSetData($HELPEDIT, "Teleport to any Sprint." & @CRLF & @CRLF & "Press Start!")
				Case "Pursuit Bot"
					GUICtrlSetData($HELPEDIT, "Teleport to any Pursuit." & @CRLF & @CRLF & "Press Start!")
				Case "Sandbox (TeamEscape)"
					GUICtrlSetData($HELPEDIT, "Start 1x Game in Sandboxie." & @CRLF & "Start 1x Game Normal." & @CRLF & "Teleport to High-Stakes." & @CRLF & "Invite Both Drivers in a Group." & @CRLF & @CRLF & "Press Start!")
				Case "Sandbox (Race/Drag)"
					GUICtrlSetData($HELPEDIT, "Start 1x Game in Sandboxie." & @CRLF & "Start 1x Game Normal." & @CRLF & "Teleport to a 'Race/Drag." & @CRLF & "Invite Both Drivers  in a Group." & @CRLF & @CRLF & "Press Start!")
				Case "Group (Race/Drag)"
					GUICtrlSetData($HELPEDIT, "Invite Friends to a Group." & @CRLF & "Teleport to any 'Race/Drag." & @CRLF & "Decide who will be the Host." & @CRLF & @CRLF & "Then Press Start!")
				Case "TeamEscape (MP)"
					GUICtrlSetData($HELPEDIT, "Teleport to any Team Escape." & @CRLF & @CRLF & "Press Start!")
				Case "World Race (MP)"
					GUICtrlSetData($HELPEDIT, "Teleport to any Race." & @CRLF & @CRLF & "Press Start!")
				Case "Vinyl (Achievement)"
					GUICtrlSetData($HELPEDIT, "Enter Safehouse." & @CRLF & "Enter Customization." & @CRLF & "Press Start!" & @CRLF & @CRLF & "Car needs to be Clean!")
				Case "Paint (Achievement)"
					GUICtrlSetData($HELPEDIT, "Enter Safehouse." & @CRLF & "Enter Customization." & @CRLF & "Press Start!")
				Case "Aftermarket (Achievement)"
					GUICtrlSetData($HELPEDIT, "Enter Safehouse." & @CRLF & "Enter Customization." & @CRLF & "Press Start!")
				Case "Skill Bot (Sells 1/2* Skills)"
					GUICtrlSetData($HELPEDIT, "Enter Safehouse." & @CRLF & "Enter Customization." & @CRLF & "Choose 'Skill' Shop." & @CRLF & "Change to Inventory." & @CRLF & @CRLF & "Press Start!")
				Case "Part Bot (Sells 1/2* Parts)"
					GUICtrlSetData($HELPEDIT, "Enter Safehouse." & @CRLF & "Enter Customization." & @CRLF & "Choose 'Tuning' Shop." & @CRLF & "Change to Inventory." & @CRLF & @CRLF & "Press Start!")
				Case "Free Slots (GMZ Purs.Bot)"
					GUICtrlSetData($HELPEDIT, "Enter Safehouse." & @CRLF & "Close Chat Window." & @CRLF & @CRLF & "Press Start!")
				Case Else
					GUICtrlSetData($HELPEDIT, "Select Bot with combobox." & @CRLF & @CRLF & "Note: Set Game to 800x600 Windowed Mode for all Bot's")
			EndSwitch
		Case $MSG[0] = $MAINCOMB
			Switch GUICtrlRead($MAINCOMB)
				Case "Mystery Cards"
					GUICtrlSetState($MAINPACKLABEL, 16)
					GUICtrlSetState($MAINPACKCOUNT, 16)
					GUICtrlSetState($MAINSPEEDX4, 32)
					GUICtrlSetState($MAINSPEEDX8, 32)
					GUICtrlSetState($MAINCOOL, 32)
					GUICtrlSetState($MAINSPEEDLABEL, 32)
					GUICtrlSetState($MAINCOOLLABEL, 32)
					GUICtrlSetState($MAINSPEEDX4LABEL, 32)
					GUICtrlSetState($MAINSPEEDX8LABEL, 32)
					GUICtrlSetState($MAINHOSTLABEL, 32)
					GUICtrlSetState($MAINHOST, 32)
				Case "Single Player Race"
					GUICtrlSetState($MAINPACKLABEL, 32)
					GUICtrlSetState($MAINPACKCOUNT, 32)
					GUICtrlSetState($MAINSPEEDX4, 16)
					GUICtrlSetState($MAINSPEEDLABEL, 16)
					GUICtrlSetState($MAINSPEEDX8, 16)
					GUICtrlSetState($MAINCOOL, 32)
					GUICtrlSetState($MAINCOOLLABEL, 32)
					GUICtrlSetState($MAINSPEEDX4LABEL, 16)
					GUICtrlSetState($MAINSPEEDX8LABEL, 16)
					GUICtrlSetState($MAINHOSTLABEL, 32)
					GUICtrlSetState($MAINHOST, 32)
				Case "Pursuit Bot"
					GUICtrlSetState($MAINPACKLABEL, 32)
					GUICtrlSetState($MAINPACKCOUNT, 32)
					GUICtrlSetState($MAINSPEEDX4, 16)
					GUICtrlSetState($MAINSPEEDLABEL, 16)
					GUICtrlSetState($MAINSPEEDX8, 16)
					GUICtrlSetState($MAINCOOL, 16)
					GUICtrlSetState($MAINCOOLLABEL, 16)
					GUICtrlSetState($MAINSPEEDX4LABEL, 16)
					GUICtrlSetState($MAINSPEEDX8LABEL, 16)
					GUICtrlSetState($MAINHOSTLABEL, 32)
					GUICtrlSetState($MAINHOST, 32)
				Case "Group (Race/Drag)"
					GUICtrlSetState($MAINPACKLABEL, 32)
					GUICtrlSetState($MAINPACKCOUNT, 32)
					GUICtrlSetState($MAINSPEEDX4, 32)
					GUICtrlSetState($MAINSPEEDLABEL, 32)
					GUICtrlSetState($MAINSPEEDX8, 32)
					GUICtrlSetState($MAINCOOL, 32)
					GUICtrlSetState($MAINCOOLLABEL, 32)
					GUICtrlSetState($MAINSPEEDX4LABEL, 32)
					GUICtrlSetState($MAINSPEEDX8LABEL, 32)
					GUICtrlSetState($MAINHOSTLABEL, 16)
					GUICtrlSetState($MAINHOST, 16)
				Case Else
					GUICtrlSetState($MAINPACKLABEL, 32)
					GUICtrlSetState($MAINPACKCOUNT, 32)
					GUICtrlSetState($MAINSPEEDX4, 32)
					GUICtrlSetState($MAINSPEEDLABEL, 32)
					GUICtrlSetState($MAINSPEEDX8, 32)
					GUICtrlSetState($MAINCOOL, 32)
					GUICtrlSetState($MAINCOOLLABEL, 32)
					GUICtrlSetState($MAINSPEEDX4LABEL, 32)
					GUICtrlSetState($MAINSPEEDX8LABEL, 32)
					GUICtrlSetState($MAINHOSTLABEL, 32)
					GUICtrlSetState($MAINHOST, 32)
			EndSwitch
	EndSelect
WEnd
#region UPDATER
Func _UPDATER_BOTOUTDATED()
	If IniRead($INI, "GAME", "BUILD", "1594") <> StringRight(FileGetVersion(_WINAPI_GETPROCESSWORKINGDIRECTORY(ProcessExists("nfsw.exe")) & "\nfsw.exe"), 4) Then
		Return True
	Else
		Return False
	EndIf
EndFunc
Func _UPDATER_UPDATEFOUND()
	$VERSIONFILE = _INetGetSource($VERSIONURL)
	$READVERSION = _StringBetween($VERSIONFILE, "botalot.version>>", "<<")
	If $READVERSION[0] = IniRead($INI, "BOT", "VERSION", "3.0.1") Then
		Return False
	Else
		Return True
	EndIf
EndFunc
Func _UPDATER_CLEANUP()
	FileDelete(@ScriptDir & "\TempBTL.exe")
	If StringRight(@ScriptName, 11) = "TempBTL.exe" Then
		Local $OLDEXE = IniRead(@ScriptDir & "\TempBTL.exe:Cleanup.ini", "1", "1", "Bot(A)Lot.exe")
		FileDelete($OLDEXE)
		FileCopy(@AutoItExe, @ScriptDir & "\Bot(A)Lot.exe")
		Run(@ScriptDir & "\Bot(A)Lot.exe")
		_SCRIPT_CLOSE()
	EndIf
EndFunc
Func _UPDATER_BATCH()
	IF @Compiled = 1 Then
		_FileCreate("Update.bat")
		$BatchText = "@ECHO OFF" &@CRLF _
		&"echo Bot(A)Lot-Updater"&@CRLF _
		&'TASKKILL /F /FI "IMAGENAME eq '&@ScriptName&'"'&@CRLF _
		&'DEL /F "'&@ScriptFullPath&'"'&@CRLF _
		&'echo f | XCOPY /C "'&@ScriptDIR&"\TempBTL.exe"&'" "'&@ScriptFullPath&'"'&@CRLF _
		&'DEL /F "'&@ScriptDIR&"\TempBTL.exe"&'"'&@CRLF _
		&'DEL /F "'&@ScriptDir&"\Update.bat"&'"'&@CRLF _
		&'EXIT'
		FileWrite("Update.bat", $BatchText)
		Run("Update.bat", @ScriptDir, @SW_HIDE)
	EndIf
EndFunc
Func _UPDATER_UPDATE($SHOWSTATUS = True)
	FileDelete(@ScriptDir & "\TempBTL.exe")
	$READLINK = _StringBetween($VERSIONFILE, "botalot.link>>", "<<")
	Local $UPDATESIZE = InetGetSize($READLINK[0])
	Local $UPDATER = InetGet($READLINK[0], @ScriptDir & "\TempBTL.exe", 3, 1)
	If $SHOWSTATUS = True Then
		Local $OLDSTATUS = 0, $DOWNLOADSTATUS = 0
		ProgressOn("Updateing Bot(A)Lot", "Downloading", "0% - Stop downloading with F11", 0, 0, 16)
		While InetGetInfo($UPDATER, 2) <> True
			$DOWNLOADSTATUS = (InetGetInfo($UPDATER, 0) / $UPDATESIZE) * 100
			IF $DOWNLOADSTATUS <> $OLDSTATUS Then
				ProgressSet($DOWNLOADSTATUS, $DOWNLOADSTATUS & "% - Stop downloading with F11")
			EndIf
		WEnd
	Else
		While InetGetInfo($UPDATER, 2) <> True
		WEnd
	EndIf
	_UPDATER_BATCH()
	_SCRIPT_CLOSE()
EndFunc
#endregion UPDATER
#region SCRIPTSPECIFIC
Func _SCRIPT_START()
	HotKeySet("{F11}", "_Script_Close")
	_UPDATER_CLEANUP()
	ProgressOn("Loading Bot(A)Lot", "Waiting for nfsw.exe", "0% - Stop loading with F11", 0, 0, 16)
	ProcessWait("nfsw.exe")
	ProgressSet(0, "Checking nfsw.exe version,", "0% - Stop loading with F1")
	ProgressSet(0, "Checking botalot version,", "0% - Stop loading with F1")
	If _UPDATER_BOTOUTDATED() = True Then
		If _UPDATER_UPDATEFOUND() = False Then
			MsgBox(48, "Bot(A)Lot™ - Warning", "This version of Bot(A)Lot™ is outdated." & @CRLF & "There is currently no update availabile." & @CRLF & @CRLF & "Bot will now close.")
			_SCRIPT_CLOSE()
		Else
			$MSG = MsgBox(308, "Bot(A)Lot™ - Warning", "This version of Bot(A)Lot™ is outdated." & @CRLF & "Do you want to download new version?" & @CRLF & @CRLF & "Current version: " & IniRead($INI, "BOT", "VERSION", "3.0.1") & @CRLF & "New version: " & $READVERSION[0])
			Switch $MSG
				Case 6
					_UPDATER_UPDATE()
					_SCRIPT_CLOSE()
				Case 7
					_SCRIPT_CLOSE()
			EndSwitch
		EndIf
	EndIf
	ProgressSet(20, "Unpacking files", "20% - Stop loading with F1")
	FileInstall("Bot4.dll", @TempDir & "\Bot4.dll", 1)
	FileInstall("Bot8.dll", @TempDir & "\Bot8.dll", 1)
	FileInstall("Splash.gif", @TempDir & "\Splash.gif")
	ProgressSet(30, "Loading/writing configuration file", "30% - Stop loading with F1")
	ProgressSet(100, "Done", "100% - Stop loading with F1")
	ProgressOff()
EndFunc
Func _SCRIPT_CLOSE()
	FileDelete(@TempDir & "\Bot4.dll")
	FileDelete(@TempDir & "\Bot8.dll")
	FileDelete(@TempDir & "\Splash.gif")
	Exit
EndFunc
Func _SCRIPT_RESTART($FEXIT = 1)
	Local $PID
	If Not $__RESTART Then
		If @Compiled Then
			$PID = Run(@ScriptFullPath & " " & $CMDLINERAW, @ScriptDir, Default, 1)
		Else
			$PID = Run(@AutoItExe & ' "' & @ScriptFullPath & '" ' & $CMDLINERAW, @ScriptDir, Default, 1)
		EndIf
		If @error Then
			Return SetError(@error, 0, 0)
		EndIf
		StdinWrite($PID, @AutoItPID)
	EndIf
	$__RESTART = 1
	If $FEXIT Then
		Sleep(50)
		Exit
	EndIf
	Return 1
EndFunc
Func _SPLASHCHECK()
	If _IsPressed("01") = 1 Then
		SplashOff()
		AdlibUnRegister("_SplashCheck")
	EndIf
EndFunc
Func _ERRORCHECK()
	Sleep(50)
	Local $PID = ConsoleRead(1)
	If @extended Then
		IniWrite(@ScriptFullPath & ":" & StringTrimRight(@ScriptName, 3) & "ini", "BOT", "LASTERROR", @extended)
		While ProcessExists($PID)
			Sleep(100)
		WEnd
	EndIf
EndFunc
Func _CREATEREPORT()
	IniWrite($REPORTINI, "BOT", "VERSION", "3.0.1")
	IniWrite($REPORTINI, "GAME", "BUILD", "1594")
	IniWrite($REPORTINI, "BOT", "LASTRUN", $DATE)
	IniWrite($REPORTINI, "BOT", "LASTERROR", IniRead($INI, "BOT", "LASTERROR", @extended))
EndFunc
Func __GetOSLanguage($Lang = "")
	Local $A = DllCall('kernel32.dll', 'int', 'GetLocaleInfoW', 'ulong', Dec($Lang), 'dword', 114, 'wstr', '', 'int', 2048)
	Return $A[3]
EndFunc ;==>__GetOSLanguage
#endregion SCRIPTSPECIFIC
#region String
Func _INetGetSource($S_URL, $BSTRING = True)
	Local $SSTRING = InetRead($S_URL, 1)
	Local $NERROR = @error, $NEXTENDED = @extended
	If $BSTRING Then $SSTRING = BinaryToString($SSTRING)
	Return SetError($NERROR, $NEXTENDED, $SSTRING)
EndFunc
Func _StringBetween($S_STRING, $S_START, $S_END, $V_CASE = -1)
	Local $S_CASE = ""
	If $V_CASE = Default Or $V_CASE = -1 Then $S_CASE = "(?i)"
	Local $S_PATTERN_ESCAPE = "(\.|\||\*|\?|\+|\(|\)|\{|\}|\[|\]|\^|\$|\\)"
	$S_START = StringRegExpReplace($S_START, $S_PATTERN_ESCAPE, "\\$1")
	$S_END = StringRegExpReplace($S_END, $S_PATTERN_ESCAPE, "\\$1")
	If $S_START = "" Then $S_START = "\A"
	If $S_END = "" Then $S_END = "\z"
	Local $A_RET = StringRegExp($S_STRING, "(?s)" & $S_CASE & $S_START & "(.*?)" & $S_END, 3)
	If @error Then Return SetError(1, 0, 0)
	Return $A_RET
EndFunc
#endregion String
#region WINAPI
Func _IsPressed($SHEXKEY, $VDLL = "user32.dll")
	Local $A_R = DllCall($VDLL, "short", "GetAsyncKeyState", "int", "0x" & $SHEXKEY)
	If @error Then Return SetError(@error, @extended, False)
	Return BitAND($A_R[0], 32768) <> 0
EndFunc
Func __IIF($FTEST, $ITRUE, $IFALSE)
	If $FTEST Then
		Return $ITRUE
	Else
		Return $IFALSE
	EndIf
EndFunc
Func _WINAPI_GETPROCESSWORKINGDIRECTORY($PID = 0)
	If Not $PID Then $PID = @AutoItPID
	Local $RET, $ERROR = 0
	Local $HPROCESS = DllCall("kernel32.dll", "handle", "OpenProcess", "dword", __IIF($__WINVER < 1536, 1040, 4112), "bool", 0, "dword", $PID)
	If @error Or Not $HPROCESS[0] Then Return SetError(@error + 20, @extended, "")
	$HPROCESS = $HPROCESS[0]
	Local $TPBI = DllStructCreate("ulong_ptr ExitStatus;ptr PebBaseAddress;ulong_ptr AffinityMask;ulong_ptr BasePriority;ulong_ptr UniqueProcessId;ulong_ptr InheritedFromUniqueProcessId")
	Local $TPEB = DllStructCreate("byte InheritedAddressSpace;byte ReadImageFileExecOptions;byte BeingDebugged;byte Spare;ptr Mutant;ptr ImageBaseAddress;ptr LoaderData;ptr ProcessParameters;ptr SubSystemData;ptr ProcessHeap;ptr FastPebLock;ptr FastPebLockRoutine;ptr FastPebUnlockRoutine;ulong EnvironmentUpdateCount;ptr KernelCallbackTable;ptr EventLogSection;ptr EventLog;ptr FreeList;ulong TlsExpansionCounter;ptr TlsBitmap;ulong TlsBitmapBits[2];ptr ReadOnlySharedMemoryBase;ptr ReadOnlySharedMemoryHeap;ptr ReadOnlyStaticServerData;ptr AnsiCodePageData;ptr OemCodePageData;ptr UnicodeCaseTableData;ulong NumberOfProcessors;ulong NtGlobalFlag;byte Spare2[4];int64 CriticalSectionTimeout;ulong HeapSegmentReserve;ulong HeapSegmentCommit;ulong HeapDeCommitTotalFreeThreshold;ulong HeapDeCommitFreeBlockThreshold;ulong NumberOfHeaps;ulong MaximumNumberOfHeaps;ptr ProcessHeaps;ptr GdiSharedHandleTable;ptr ProcessStarterHelper;ptr GdiDCAttributeList;ptr LoaderLock;ulong OSMajorVersion;ulong OSMinorVersion;ulong OSBuildNumber;ulong OSPlatformId;ulong ImageSubSystem;ulong ImageSubSystemMajorVersion;ulong ImageSubSystemMinorVersion;ulong GdiHandleBuffer[34];ulong PostProcessInitRoutine;ulong TlsExpansionBitmap;byte TlsExpansionBitmapBits[128];ulong SessionId")
	Local $TUPP = DllStructCreate("ulong AllocationSize;ulong ActualSize;ulong Flags;ulong Unknown1;ushort LengthUnknown2;ushort MaxLengthUnknown2;ptr Unknown2;ptr InputHandle;ptr OutputHandle;ptr ErrorHandle;ushort LengthCurrentDirectory;ushort MaxLengthCurrentDirectory;ptr CurrentDirectory;ptr CurrentDirectoryHandle;ushort LengthSearchPaths;ushort MaxLengthSearchPaths;ptr SearchPaths;ushort LengthApplicationName;ushort MaxLengthApplicationName;ptr ApplicationName;ushort LengthCommandLine;ushort MaxLengthCommandLine;ptr CommandLine;ptr EnvironmentBlock;ulong Unknown[9];ushort LengthUnknown3;ushort MaxLengthUnknown3;ptr Unknown3;ushort LengthUnknown4;ushort MaxLengthUnknown4;ptr Unknown4;ushort LengthUnknown5;ushort MaxLengthUnknown5;ptr Unknown5")
	Local $TDIR
	Do
		$RET = DllCall("ntdll.dll", "long", "NtQueryInformationProcess", "handle", $HPROCESS, "ulong", 0, "struct*", $TPBI, "ulong", DllStructGetSize($TPBI), "ulong*", 0)
		If @error Or ($RET[0]) Then
			$ERROR = @error + 10
			ExitLoop
		EndIf
		$RET = DllCall("kernel32.dll", "bool", "ReadProcessMemory", "handle", $HPROCESS, "ptr", DllStructGetData($TPBI, "PebBaseAddress"), "struct*", $TPEB, "ulong_ptr", DllStructGetSize($TPEB), "ulong_ptr*", 0)
		If @error Or (Not $RET[0]) Or (Not $RET[5]) Then
			$ERROR = @error + 30
			ExitLoop
		EndIf
		$RET = DllCall("kernel32.dll", "bool", "ReadProcessMemory", "handle", $HPROCESS, "ptr", DllStructGetData($TPEB, "ProcessParameters"), "struct*", $TUPP, "ulong_ptr", DllStructGetSize($TUPP), "ulong_ptr*", 0)
		If @error Or (Not $RET[0]) Or (Not $RET[5]) Then
			$ERROR = @error + 40
			ExitLoop
		EndIf
		$TDIR = DllStructCreate("byte[" & DllStructGetData($TUPP, "MaxLengthCurrentDirectory") & "]")
		If @error Then
			$ERROR = @error + 50
			ExitLoop
		EndIf
		$RET = DllCall("kernel32.dll", "bool", "ReadProcessMemory", "handle", $HPROCESS, "ptr", DllStructGetData($TUPP, "CurrentDirectory"), "struct*", $TDIR, "ulong_ptr", DllStructGetSize($TDIR), "ulong_ptr*", 0)
		If @error Or (Not $RET[0]) Or (Not $RET[5]) Then
			$ERROR = @error + 60
			ExitLoop
		EndIf
		$ERROR = 0
	Until 1
	DllCall("kernel32.dll", "bool", "CloseHandle", "handle", $HPROCESS)
	If $ERROR Then Return SetError($ERROR, 0, "")
	Return _WINAPI_PATHREMOVEBACKSLASH(_WINAPI_GETSTRING(DllStructGetPtr($TDIR)))
EndFunc
Func __WINVER()
	Local $TOSVI = DllStructCreate("dword;dword;dword;dword;dword;wchar[128]")
	DllStructSetData($TOSVI, 1, DllStructGetSize($TOSVI))
	Local $RET = DllCall("kernel32.dll", "int", "GetVersionExW", "ptr", DllStructGetPtr($TOSVI))
	If (@error) Or (Not $RET[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return BitOR(BitShift(DllStructGetData($TOSVI, 2), -8), DllStructGetData($TOSVI, 3))
EndFunc
Func _WINAPI_PATHREMOVEBACKSLASH($SPATH)
	Local $RET = DllCall("shlwapi.dll", "ptr", "PathRemoveBackslashW", "wstr", $SPATH)
	If @error Then Return SetError(@error, @extended, "")
	Return $RET[1]
EndFunc
Func _WINAPI_GETSTRING($PSTRING, $FUNICODE = 1)
	Local $LENGTH = _WINAPI_STRLEN($PSTRING, $FUNICODE)
	If @error Or Not $LENGTH Then Return SetError(@error + 10, @extended, "")
	Local $TSTRING = DllStructCreate(__IIF($FUNICODE, "wchar", "char") & "[" & ($LENGTH + 1) & "]", $PSTRING)
	If @error Then Return SetError(@error, @extended, "")
	Return SetExtended($LENGTH, DllStructGetData($TSTRING, 1))
EndFunc
Func _WINAPI_STRLEN($PSTRING, $FUNICODE = 1)
	Local $W = ""
	If $FUNICODE Then $W = "W"
	Local $RET = DllCall("kernel32.dll", "int", "lstrlen" & $W, "ptr", $PSTRING)
	If @error Then Return SetError(@error, @extended, 0)
	Return $RET[0]
EndFunc
Func _FileCreate($sFilePath)
	Local $hOpenFile = FileOpen($sFilePath, 2)
	If $hOpenFile = -1 Then Return SetError(1, 0, 0)
	Local $hWriteFile = FileWrite($hOpenFile, "")
	FileClose($hOpenFile)
	If $hWriteFile = -1 Then Return SetError(2, 0, 0)
	Return 1
EndFunc   ;==>_FileCreate
#endregion WINAPI
; DeTokenise by myAut2Exe >The Open Source AutoIT/AutoHotKey script decompiler< 2.12 build(182)
