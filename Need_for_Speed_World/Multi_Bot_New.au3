#RequireAdmin
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <EditConstants.au3>

#region HotKey
HotKeySet("{F11}", "_RageQuit")
#endregion HotKey

#region Variables
Global $Welcome = 0, $EasterEgg = 0, $IsStarted = 0, $ForSell = 0, $Scrolled = 0
Global $Mode, $Pos[2], $OldPos[2]
#endregion Variables

#region Constants
#region VK_KEYS
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
Global Const $TH32CS_SNAPPROCESS = 0x00000002
Global Const $TH32CS_SNAPMODULE = 0x00000008
Global Const $TH32CS_SNAPMODULE32 = 0x00000010
Global Const $PROCESS_ALL_ACCESS = 0x001F0FFF
;_______
Global Const $NFSW_HWND = "[CLASS:GameFrame]"
Global Const $SBOX_HWND = "[REGEXPCLASS:Sandbox:(.*?):GameFrame]"
Global Const $NFSW_MODULE = "nfsw.exe"
Global Const $GPLY_MODULE = "gameplay.native.dll"
Global Const $ByteCheck = 4926648045530641193
#endregion Constants

ConsoleWrite(Dec(_StringEncrypt(1, "ÇpD", Hex($ByteCheck))) & @CRLF)
ConsoleWrite(Dec(_StringEncrypt(1, "QQÒ ", Hex($ByteCheck))))

#region MainForm
$MainForm = GUICreate("iBOT 0.3", 159, 131, -1, -1, $WS_SYSMENU) ;Real size of form is 154, 106 actually
GUISetFont(8, 400, 0, "Segoe UI")
$MainBotSelector = GUICtrlCreateCombo("", 8, 8, 137, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "M.Cards|Drag|SP.Race|Pursuit|Sandbox|Crew Race|Vinyl|Paint|Escape|S.Sell", "M.Cards")
$MainStartButton = GUICtrlCreateButton("Start", 8, 32, 59, 17)
$MainPauseButton = GUICtrlCreateButton("Pause", 8, 32, 59, 17)
$MainContinueButton = GUICtrlCreateButton("Continue", 8, 32, 59, 17)
$MainStopButton = GUICtrlCreateButton("Stop", 8, 48, 59, 17)
$MainHelpButton = GUICtrlCreateButton("Help", 8, 64, 59, 17)
$MainCoolCheckbox = GUICtrlCreateCheckbox("Cooldown", 72, 32, 73, 17)
$MainSpeedGroup = GUICtrlCreateGroup("Speed", 72, 48, 73, 33, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
$MainSpeedX4 = GUICtrlCreateRadio("x4", 80, 64, 28, 16)
$MainSpeedX8 = GUICtrlCreateRadio("x8", 112, 64, 28, 16)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$MainStatusLabel = GUICtrlCreateLabel(" There are no easter eggs here.", 0, 88, 159, 16, 0, 131072)
#endregion MainForm
#region HelpForm
$HelpForm = GUICreate("iBOT Help", 234, 216, -1, -1, -1, BitOR($WS_EX_TOOLWINDOW, $WS_EX_WINDOWEDGE), $MainForm)
GUISetFont(8, 400, 0, "Segoe UI")
$HelpLanguageCombo = GUICtrlCreateCombo("", 8, 8, 105, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "English|German|Turkish|Romanian|Croatian|Russian", "English")
$HelpBotCombo = GUICtrlCreateCombo("", 120, 8, 105, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "M.Cards|Drag|SP.Race|Pursuit|Sandbox|Crew Race|Vinyl|Paint|Escape", "M.Cards")
$HelpRichEdit = GUICtrlCreateEdit("", 8, 32, 217, 153, BitOR($ES_AUTOVSCROLL, $ES_AUTOHSCROLL, $ES_READONLY))
GUICtrlSetData(-1, "HelpRichEdit")
GUICtrlSetBkColor(-1, 0xFFFFFF)
$HelpCreditsButton = GUICtrlCreateButton("Credits", 8, 192, 217, 17)
#endregion HelpForm
#region BeforeShowingGUI
If WinExists($NFSW_HWND) = 1 Then
	$Pos = WinGetPos($NFSW_HWND)
	If $Pos[0] < @DesktopWidth / 2 Then
		WinMove($MainForm, "", $Pos[0] + $Pos[2], $Pos[1] + 30)
	Else
		WinMove($MainForm, "", $Pos[0], $Pos[1] + 30)
	EndIf
EndIf
GUICtrlSetState($MainPauseButton, 32) ;128 = Disable, 64 = Enable, 32 = Hide, 16 = Show
GUICtrlSetState($MainContinueButton, 32)
GUICtrlSetState($MainStopButton, 128)
GUICtrlSetState($MainCoolCheckbox, 128)
GUICtrlSetState($MainSpeedX4, 128)
GUICtrlSetState($MainSpeedX8, 128)
GUISetState(@SW_SHOW, $MainForm)
AdlibRegister("_Welcome", 1000)
#endregion BeforeShowingGUI

While 1
	$Msg = GUIGetMsg(1) ;This needs to be here, putting it above GUI will fck everything up
	Select
		;HELP FORM
		Case $Msg[0] = -3 And $Msg[1] = $HelpForm ;Close Button on HelpForm
			$Pos = WinGetPos($HelpForm) ;Get Position of HelpForm
			WinMove($MainForm, "", $Pos[0], $Pos[1]) ;Move MainForm to HelpForm's coordinates
			GUISetState(@SW_HIDE, $HelpForm)
			GUISetState(@SW_SHOW, $MainForm)
		Case $Msg[0] = $HelpCreditsButton And $Msg[1] = $HelpForm ;Credits Button on HelpForm
			If $EasterEgg = 1 Then ;Little EasterEgg I added :D
				MsgBox(64, "Everyone is dead, and im drunk. Why god why :O?", "This version of iBOT is not approved by Android :(") ;Troll credits
				$EasterEgg = 0
			Else
				MsgBox(32, "iBOT Credits", "Farming Inc. and berkay2578") ;Normal credits
				$EasterEgg += 1
			EndIf
			;MAIN FORM
		Case $Msg[0] = -3 And $Msg[1] = $MainForm ;Close button on MainForm
			Exit
		Case $Msg[0] = $MainHelpButton And $Msg[1] = $MainForm ;Help button on MainForm
			$Pos = WinGetPos($MainForm) ;Get Position of MainForm
			WinMove($HelpForm, "", $Pos[0], $Pos[1]) ;Move HelpForm to MainForm's coordinates
			GUISetState(@SW_HIDE, $MainForm)
			GUISetState(@SW_SHOW, $HelpForm)
		Case $Msg[0] = $MainBotSelector And $Msg[1] = $MainForm ;Bot is selected
			Switch GUICtrlRead($MainBotSelector)
				Case "SP.Race"
					GUICtrlSetState($MainCoolCheckbox, 128)
					GUICtrlSetState($MainSpeedX4, 64)
					GUICtrlSetState($MainSpeedX8, 64)
				Case "Pursuit"
					GUICtrlSetState($MainCoolCheckbox, 64)
					GUICtrlSetState($MainSpeedX4, 64)
					GUICtrlSetState($MainSpeedX8, 64)
				Case Else ;If not pursuit or sp.race then this disables everything
					GUICtrlSetState($MainCoolCheckbox, 128)
					GUICtrlSetState($MainSpeedX4, 128)
					GUICtrlSetState($MainSpeedX8, 128)
			EndSwitch
		Case $Msg[0] = $MainStartButton And $Msg[1] = $MainForm ;THIS IS THE BOT :D
			Switch GUICtrlRead($MainBotSelector)
				Case "M.Cards" ;Mystery Cards
					GUICtrlSetState($MainStartButton, 32) ;Hide Start button
					GUICtrlSetState($MainPauseButton, 16) ;Show pause button
					GUICtrlSetState($MainContinueButton, 32) ;Hide continue button
					GUICtrlSetState($MainStopButton, 64) ;Enable Stop button
					AdlibRegister("_EventCheck", 100)
					$IsStarted = 1
					While $IsStarted = 1
						If $IsStarted = 1 Then
							GUICtrlSetData($MainStatusLabel, " Step1 = G, C, L, 665, 490")
							_SendMessage_Click($NFSW_HWND, 665, 490, "left")
							Sleep(500)
						EndIf
						If $IsStarted = 1 Then
							GUICtrlSetData($MainStatusLabel, " Step2 = G, C, L, 145, 490")
							_SendMessage_Click($NFSW_HWND, 145, 490, "left")
							Sleep(500)
						EndIf
						_EventCheck("Stop")
					WEnd
				Case "Vinyl"
					GUICtrlSetState($MainStartButton, 32) ;Hide Start button
					GUICtrlSetState($MainPauseButton, 16) ;Show pause button
					GUICtrlSetState($MainContinueButton, 32) ;Hide continue button
					GUICtrlSetState($MainStopButton, 64) ;Enable Stop button
					AdlibRegister("_EventCheck", 100)
					Opt("MouseCoordMode", 2)
					$IsStarted = 1
					While $IsStarted = 1
						If $IsStarted = 1 Then
							ControlClick("NEED FOR SPEED™ WORLD", "", "", "left", 1, 570, 320)
							While _Check("InVinyl") <> 1
								Sleep(100)
							WEnd
							Sleep(500) ;____
							While _Check("VinylCount") <> 31
								_SendMessage_ClickDrag($NFSW_HWND, 585, 170, 340, 305, "left", 1)
								Sleep(10)
							WEnd
							ControlClick("NEED FOR SPEED™ WORLD", "", "", "left", 1, 80, 25)
							Sleep(300)
							ControlClick("NEED FOR SPEED™ WORLD", "", "", "left", 1, 550, 330)
							While _Check("InVinyl") <> 0
								Sleep(100)
							WEnd
							Sleep(500) ;___
							ControlClick("NEED FOR SPEED™ WORLD", "", "", "left", 1, 570, 320)
							While _Check("InVinyl") <> 1
								Sleep(100)
							WEnd
							Sleep(500) ;____
							While _Check("VinylCount") <> 0
								ControlClick("NEED FOR SPEED™ WORLD", "", "", "left", 1, 570, 320)
								ControlClick("NEED FOR SPEED™ WORLD", "", "", "left", 1, 100, 250)
								Sleep(10)
							WEnd
							ControlClick("NEED FOR SPEED™ WORLD", "", "", "left", 1, 80, 25)
							Sleep(300)
							ControlClick("NEED FOR SPEED™ WORLD", "", "", "left", 1, 550, 330)
							While _Check("InVinyl") <> 0
								Sleep(100)
							WEnd
							Sleep(500) ;____
						EndIf
					WEnd
				Case "S.Sell"
					GUICtrlSetState($MainStartButton, 32) ;Hide Start button
					GUICtrlSetState($MainPauseButton, 16) ;Show pause button
					GUICtrlSetState($MainContinueButton, 32) ;Hide continue button
					GUICtrlSetState($MainStopButton, 64) ;Enable Stop button
					AdlibRegister("_EventCheck", 100)
					;NFSW CHECK
					WinMove($NFSW_HWND, "", @DesktopHeight, @DesktopWidth)
					$IsStarted = 1
					$ForSell = 0 ;If 10 it sells, to prevent unknown error
					$Scrolled = 0 ;After it clicks scroll 200 times it will check the last 4 skills then stop
					GUICtrlSetData($MainStatusLabel, " Step0 = G, C, L, 755, 390") ;To reduce chances of lag

					For $i = 0 To _Check("SkillAmmount") Step 1 ;Scroll all the way down, because if you sell from top to bottom it will bug
						_SendMessage_Click($NFSW_HWND, 755, 390, "left")
					Next

					While $IsStarted = 1
						If $IsStarted = 1 Then
							GUICtrlSetData($MainStatusLabel, " Step1 = G, C, L, 615, 385")
							_SendMessage_Click($NFSW_HWND, 615, 385, "left") ;Select the bottom skill
						EndIf

						If _Check("SkillStar") = 1 And $IsStarted = 1 Then ;Check if its 1 star skill
							GUICtrlSetData($MainStatusLabel, " Step2 = G, CD, L, 615, 385, 590, 540")
							_SendMessage_ClickDrag($NFSW_HWND, 615, 385, 590, 540, "left") ;Drag 1 star skill to sell area
							$ForSell += 1
						EndIf

						If $ForSell = 10 And $IsStarted = 1 Then
							GUICtrlSetData($MainStatusLabel, " Step3 = G, C, L, 275, 580")
							_SendMessage_Click($NFSW_HWND, 275, 580, "left") ;Click save changes
							Sleep(500)
							GUICtrlSetData($MainStatusLabel, " Step4 = G, C, L, 500, 330")
							_SendMessage_Click($NFSW_HWND, 500, 330, "left") ;Click yes a.k.a. sell skills
							Sleep(6000) ;6000 is kinda optimal
							$ForSell = 0
						EndIf

						If $IsStarted = 1 Then
							GUICtrlSetData($MainStatusLabel, " Step5 = G, C, L, 755, 130")
							_SendMessage_Click($NFSW_HWND, 755, 130, "left") ;Press arrow up
							$Scrolled += 1
						EndIf

						If $Scrolled >= _Check("SkillAmmount") And $IsStarted = 1 Then ;Check if top is reached
							If $ForSell > 0 Then ;Sell current skills then check last 4 skills
								GUICtrlSetData($MainStatusLabel, " Step3 = G, C, L, 275, 580")
								_SendMessage_Click($NFSW_HWND, 275, 580, "left") ;Click save changes
								Sleep(500)
								GUICtrlSetData($MainStatusLabel, " Step4 = G, C, L, 500, 330")
								_SendMessage_Click($NFSW_HWND, 500, 330, "left") ;Click yes a.k.a. sell skills
								Sleep(6000) ;6000 is kinda optimal
								$ForSell = 0
							EndIf

							For $y = 385 To 145 Step -60 ;LOOP FOR CHECKING LAST 4 SKILLS
								If $IsStarted = 1 Then
									GUICtrlSetData($MainStatusLabel, " Step1 = G, C, L, 615, " & $Y)
									_SendMessage_Click($NFSW_HWND, 615, $y, "left")
								EndIf
								If _Check("SkillStar") = 1 And $IsStarted = 1 Then
									GUICtrlSetData($MainStatusLabel, " Step2 = G, CD, L, 615, " & $Y & ", 590, 540")
									_SendMessage_ClickDrag($NFSW_HWND, 615, $y, 590, 540, "left")
									$ForSell += 1
								EndIf
							Next

							If $ForSell > 0 Then ;If one of last 4 skills is 1 star then sell
								GUICtrlSetData($MainStatusLabel, " Step3 = G, C, L, 275, 580")
								_SendMessage_Click($NFSW_HWND, 275, 580, "left") ;Click save changes
								Sleep(500)
								GUICtrlSetData($MainStatusLabel, " Step4 = G, C, L, 500, 330")
								_SendMessage_Click($NFSW_HWND, 500, 330, "left") ;Click yes a.k.a. sell skills
								$ForSell = 0 ;No sleep because its end of bot, no need to sleep
							EndIf
							_EventCheck("Stop") ;END OF BOT
						EndIf
					WEnd
			EndSwitch
	EndSelect
WEnd

Func _Welcome() ;Welcome MSG func
	Switch $Welcome
		Case 0
			GUICtrlSetData($MainStatusLabel, " Loading / Please wait")
			$Welcome = $Welcome + 1
		Case 1
			GUICtrlSetData($MainStatusLabel, " ©2013 Farming Inc. Europe")
			$Welcome = $Welcome + 1
			AdlibUnRegister("_Welcome")
	EndSwitch
EndFunc   ;==>_Welcome

Func _RageQuit()
	Exit
EndFunc   ;==>_RageQuit

Func _EventCheck($Mode = "Normal")
	$Msg = GUIGetMsg()
	Select
		Case $Msg = $MainPauseButton Or $Mode = "Pause"
			GUICtrlSetState($MainPauseButton, 32) ;Hide Pause button
			GUICtrlSetState($MainContinueButton, 16) ;Show Continue button
			GUICtrlSetState($MainStopButton, 128) ;Disable Stop button
			Do
				If GUIGetMsg() = -3 Then
					Exit
				EndIf
				If GUIGetMsg() = $MainContinueButton Then ;Somehow this fixes continue button being too slow
					ExitLoop
				EndIf
			Until GUIGetMsg() = $MainContinueButton
			GUICtrlSetState($MainContinueButton, 32) ;Hide Continue button
			GUICtrlSetState($MainPauseButton, 16) ;Show Pause button
			GUICtrlSetState($MainStopButton, 64) ;Enable Stop button
		Case $Msg = $MainStopButton Or $Mode = "Stop"
			$IsStarted = 0
			GUICtrlSetState($MainPauseButton, 32) ;128 = Disable, 64 = Enable, 32 = Hide, 16 = Show
			GUICtrlSetState($MainStartButton, 16)
			GUICtrlSetState($MainStopButton, 128)
			GUICtrlSetData($MainStatusLabel, " ©2013 Farming Inc. Europe")
			WinMove($NFSW_HWND, "", 0, 0)
			AdlibUnRegister("_EventCheck")
		Case $Msg = -3 Or $Mode = "RageQuit"
			Exit
	EndSelect
EndFunc   ;==>_EventCheck

#region Cheats
Func _Check($Bool)
	Switch $Bool
		;Vinyl
		Case "InVinyl"
			$Handle = _Process_Open(WinGetProcess($NFSW_MODULE))
			$Offset = Dec(_StringEncrypt(1, "ÇpD", Hex($ByteCheck)))
			$Base = _Module_GetBaseAddress($Handle, $NFSW_MODULE) + $Offset
			$Return = _Process_ReadMemory($Handle, $Base, "BYTE")
			Return $Return
		Case "VinylCount"
			$Handle = _Process_Open($NFSW_MODULE)
			$Offset = Dec(_StringEncrypt(1, "QQÒ ", Hex($ByteCheck)))
			$Base = _Module_GetBaseAddress($Handle, $NFSW_MODULE) + $Offset
			Local $Offsets[1] = [0x11C4]
			$Return = _Process_ReadMemoryPointer($Handle, $Base, $Offsets, "BYTE")
			Return $Return

		;Paint
		Case "InPaint"
			$Handle = _Process_Open($NFSW_MODULE)
			$Offset = Dec(_StringEncrypt(1, "Ç]ß", Hex($ByteCheck)))
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

#region Includes
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
	Local $RET, $sRET = "", $iBinLen, $iHexWords

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
		$RET = $s_EncryptText
		For $n = 1 To $i_EncryptLevel
			If $n > 1 Then $RET = Binary(Random(0, 2 ^ 31 - 1, 1)) & $RET & Binary(Random(0, 2 ^ 31 - 1, 1)) ; prepend/append random 32bits
			$RET = rc4($s_EncryptPassword, $RET) ; returns binary
		Next

		; Convert to hex string
		$iBinLen = BinaryLen($RET)
		$iHexWords = Int($iBinLen / 4)
		If Mod($iBinLen, 4) Then $iHexWords += 1
		For $n = 1 To $iHexWords
			$sRET &= Hex(BinaryMid($RET, 1 + (4 * ($n - 1)), 4))
		Next
		$RET = $sRET
	Else
		; Decrypt selected
		; Convert input string to primary binary
		$RET = Binary("0x" & $s_EncryptText) ; Convert string to binary

		; Additional passes, if required
		For $n = 1 To $i_EncryptLevel
			If $n > 1 Then
				$iBinLen = BinaryLen($RET)
				$RET = BinaryMid($RET, 5, $iBinLen - 8) ; strip random 32bits from both ends
			EndIf
			$RET = rc4($s_EncryptPassword, $RET)
		Next
		$RET = BinaryToString($RET)
	EndIf

	; Return result
	Return $RET
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
#region SendMessage
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
	$RET = DllCall($User32, "int", "MapVirtualKey", "int", $key, "int", 0)
	If IsArray($RET) Then
		DllCall($User32, "bool", "SendMessage", "HWND", $hWnd, "int", $WM_KEYDOWN, "int", $key, "long", _MakeLong(1, $RET[0]))
		Sleep($Delay)
		DllCall($User32, "bool", "SendMessage", "HWND", $hWnd, "int", $WM_KEYUP, "int", $key, "long", _MakeLong(1, $RET[0]) + 0xC0000000)
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
	$RET = DllCall($User32, "int", "MapVirtualKey", "int", $key, "int", 0)
	If IsArray($RET) Then
		DllCall($User32, "bool", "SendMessage", "HWND", $hWnd, "int", $WM_KEYDOWN, "int", $key, "long", _MakeLong(1, $RET[0]))
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
	$RET = DllCall($User32, "int", "MapVirtualKey", "int", $key, "int", 0)
	If IsArray($RET) Then
		DllCall($User32, "bool", "SendMessage", "HWND", $hWnd, "int", $WM_KEYUP, "int", $key, "long", _MakeLong(1, $RET[0]) + 0xC0000000)
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
	$RET = DllCall($User32, "short", "GetAsyncKeyState", "int", $key)
	If IsArray($RET) Then
		Return SetError(0, "", $RET[0])
	Else
		Return SetError(3, "", False)
	EndIf
EndFunc   ;==>_GetAsyncKeyState
#endregion SendMessage
#endregion Includes


