#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
Global $Paused
Global $iLoop = True
Dim $COUNT = 0
Local $MSG
Dim $arTrayWin[500][3]
$arTrayWin[0][0] = 0
$DR1 = IniRead("delays.ini", "delays", "1", "12000")
$DR2 = IniRead("delays.ini", "delays", "2", "200")
$DR3 = IniRead("delays.ini", "delays", "3", "200")
$DR4 = IniRead("delays.ini", "delays", "4", "200")
$DR5 = IniRead("delays.ini", "delays", "5", "200")
$DR6 = IniRead("delays.ini", "delays", "6", "4000")
;HOTKEYS;
HotKeySet("{DELETE}", "TP")
;GUI;
#region ### START Koda GUI section ### Form=
$GUI = GUICreate("QR BOT", 110, 160, Default, Default, BitOR($WS_SIZEBOX, $WS_THICKFRAME, $WS_SYSMENU))
GUISetFont(8, 400, 0, "Arial")
$ICOUNTR = GUICtrlCreateInput("100", 8, 8, 65, 18)
GUICtrlSetFont(-1, 6, 400, 0, "Arial")
$GO = GUICtrlCreateButton("Go!", 80, 8, 27, 17)
GUICtrlCreateLabel("Delay1", 8, 32, 37, 18)
GUICtrlCreateLabel("Delay2", 8, 48, 37, 18)
GUICtrlCreateLabel("Delay3", 8, 64, 37, 18)
GUICtrlCreateLabel("Delay4", 8, 80, 37, 18)
GUICtrlCreateLabel("Delay5", 8, 96, 37, 18)
GUICtrlCreateLabel("Delay6", 8, 112, 37, 18)
$D1 = GUICtrlCreateInput($DR1, 48, 32, 57, 18)
GUICtrlSetFont(-1, 6, 400, 0, "Arial")
$D2 = GUICtrlCreateInput($DR2, 48, 48, 57, 18)
GUICtrlSetFont(-1, 6, 400, 0, "Arial")
$D3 = GUICtrlCreateInput($DR3, 48, 64, 57, 18)
GUICtrlSetFont(-1, 6, 400, 0, "Arial")
$D4 = GUICtrlCreateInput($DR4, 48, 80, 57, 18)
GUICtrlSetFont(-1, 6, 400, 0, "Arial")
$D5 = GUICtrlCreateInput($DR5, 48, 96, 57, 18)
GUICtrlSetFont(-1, 6, 400, 0, "Arial")
$D6 = GUICtrlCreateInput($DR6, 48, 112, 57, 18)
GUICtrlSetFont(-1, 6, 400, 0, "Arial")
GUISetState(@SW_SHOW)
#endregion ### END Koda GUI section ###
;ENDGUI;
While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			GUISetState(@SW_HIDE)
			MsgBox(16, "FUK", "You don't want to use QR?", 1)
			Exit
		Case $GO
			GUISetState(@SW_HIDE, $GUI)
			$DW1 = GUICtrlRead($D1, 0)
			$DW2 = GUICtrlRead($D2, 0)
			$DW3 = GUICtrlRead($D3, 0)
			$DW4 = GUICtrlRead($D4, 0)
			$DW5 = GUICtrlRead($D5, 0)
			$DW6 = GUICtrlRead($D6, 0)
			IniWrite("delays.ini", "delays", "1", $DW1)
			IniWrite("delays.ini", "delays", "2", $DW2)
			IniWrite("delays.ini", "delays", "3", $DW3)
			IniWrite("delays.ini", "delays", "4", $DW4)
			IniWrite("delays.ini", "delays", "5", $DW5)
			IniWrite("delays.ini", "delays", "6", $DW6)
			$iLoop = True
			While 1 = 1
				$COUNT = $COUNT + 1
				ControlClick("NEED FOR SPEED™ WORLD", "", "", "left", 1, 665, 355)
				If $iLoop = False Then ExitLoop (0)
				Sleep(GUICtrlRead($D1))
				If $iLoop = False Then ExitLoop (0)
				ControlClick("NEED FOR SPEED™ WORLD", "", "", "left", 1, 665, 355)
				If $iLoop = False Then ExitLoop (0)
				Sleep(GUICtrlRead($D2))
				If $iLoop = False Then ExitLoop (0)
				ControlClick("NEED FOR SPEED™ WORLD", "", "", "left", 1, 475, 30)
				If $iLoop = False Then ExitLoop (0)
				Sleep(GUICtrlRead($D3))
				If $iLoop = False Then ExitLoop (0)
				ControlClick("NEED FOR SPEED™ WORLD", "", "", "left", 1, 360, 235)
				If $iLoop = False Then ExitLoop (0)
				Sleep(GUICtrlRead($D4))
				If $iLoop = False Then ExitLoop (0)
				ControlClick("NEED FOR SPEED™ WORLD", "", "", "left", 1, 315, 325)
				If $iLoop = False Then ExitLoop (0)
				Sleep(GUICtrlRead($D5))
				If $iLoop = False Then ExitLoop (0)
				ControlClick("NEED FOR SPEED™ WORLD", "", "", "left", 1, 665, 90)
				If $iLoop = False Then ExitLoop (0)
				Sleep(GUICtrlRead($D6))
				ToolTip("I did " & $COUNT & " races in total.", 0, 0, "Total race counter", 1)
				If $iLoop = False Then ExitLoop (0)
				If $COUNT = GUICtrlRead($ICOUNTR) Then
					MsgBox(64, "QR BOT", "I'm tired of racing!")
					Exit
				EndIf
			WEnd
	EndSwitch
WEnd

Func TP()
	$Paused = Not $Paused
	While $Paused
		Sleep(100)
		ToolTip('Script is "Paused"', 0, 0, "Important!", 2)
	WEnd
	ToolTip("")
EndFunc   ;==>TP