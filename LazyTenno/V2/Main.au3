#pragma compile(AutoItExecuteAllowed, True)
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=FI.ico
#AutoIt3Wrapper_Compression=4
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#NoTrayIcon
#RequireAdmin

#Region Declare
$IniPath = @ScriptDir&"\Settings.ini"
$ScriptPath = _FileListToArray(@ScriptDir&"\Scripts","*.au3",1,False)
$LazyTenno = "LazyTenno"
$ScriptRunning = False
Global $ScriptID[0]
#EndRegion

HotKeySet("{F11}", "Script_Run")

#Region Form
$Gui = GUICreate($LazyTenno, 367, 338)
$GuiTab = GUICtrlCreateTab(8, 8, 353, 321)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;MAIN
$TabMain = GUICtrlCreateTabItem("Main")
$MainStatus = GUICtrlCreateEdit("", 16, 40, 335, 280, BitOR(2048,0x00200000))
GUICtrlSetColor(-1, 0xC0C0C0)
GUICtrlSetBkColor(-1, 0x010101)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;SCRIPTS
$TabScript = GUICtrlCreateTabItem("Scripts")
$ScriptListLabel = GuiCtrlCreateLabel("Script List", 16, 40, 50, 16)
$ScriptList = GUICtrlCreateList("", 16, 60, 165, 240, -1, 0)
For $i=1 To $ScriptPath[0] Step 1
	GUICtrlSetData($ScriptList,$ScriptPath[$i]&"|")
Next
Status("Scripts Loaded")
$ScriptSelectedLabel = GUICtrlCreateLabel("Selected Scripts", 185, 40, 80, 16)
$ScriptSelected = GuiCtrlCreateList("", 185, 60, 165, 240, -1, 0)
$ScriptInfo = GuiCtrlCreateButton("Info ^", 15, 300, 82, 20)
$ScriptAdd = GUICtrlCreateButton("Add ->", 100, 300, 82, 20)
$ScriptDel = GuiCtrlCreateButton("<- Remove", 184, 300, 167, 20)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;HELP
$TabHelp = GUICtrlCreateTabItem("Help")
$HelpTopic = GUICtrlCreateCombo("", 16, 40, 335, 25, BitOR(0x3,0x40))
GUICtrlSetData(-1,"Introduction|How to use|Scripting","")
$HelpText = GUICtrlCreateEdit("Select a topic.", 16, 64, 335, 256, BitOR(2048,0x00200000))
GUICtrlCreateTabItem("")
GUISetState(@SW_SHOW)
Status("GUI Loaded")
#EndRegion Form
Status("LazyTenno started")

While 1
	$Msg = GUIGetMsg()
	Switch $Msg
		Case -3
			Exit
		Case $HelpTopic
			Help()
		Case $ScriptInfo
			Script_Info(GuiCtrlRead($ScriptList))
		Case $ScriptAdd
			Script_Add(GuiCtrlRead($ScriptList))
		Case $ScriptDel
			Script_Del(GuiCtrlRead($ScriptSelected))
	EndSwitch
WEnd

#Region Main
Func Status($TextLine)
	Local $Text = GuiCtrlRead($MainStatus)
	$Text = $Text & "["&@HOUR&":"&@MIN&":"&@SEC&"] " & $TextLine & @CRLF
	GUICtrlSetData($MainStatus,$Text)
EndFunc
Func Terminate()
	If $ScriptRunning = True Then
		Script_Stop()
	EndIf
	Exit
EndFunc
#EndRegion
#Region Script
Func Script_Add($Path)
	If $Path And _GUICtrlListBox_FindString($ScriptSelected, $Path, True) = -1 Then
		GUICtrlSetData($ScriptSelected, $Path&"|")
		Status("Script_Add() -> Success")
	Else
		Status("Script_Add() -> Fail")
	EndIf
EndFunc
Func Script_Del($Path)
	If $Path Then
		$Index = _GUICtrlListBox_FindString($ScriptSelected, $Path, True)
		_GUICtrlListBox_DeleteString($ScriptSelected, $Index)
		Status("Script_Del() -> Success")
	Else
		Status("Script_Del() -> Fail")
	EndIf
Endfunc
Func Script_Info($Path)
	If $Path Then
		$Path = @ScriptDir&"\Scripts" & "\" & $Path
		$Name = _StringBetween(FileReadLine($Path,1), ";<Name>", "</Name>")
		$Category = _StringBetween(FileReadLine($Path,2), ";<Category>", "</Category>")
		$Author = _StringBetween(FileReadLine($Path,3), ";<Author>", "</Author>")
		$Text = "Name: " & $Name[0] & @CRLF & "Category: " & $Category[0] & @CRLF & _
				"Author: " & $Author[0]
		MsgBox(64, $LazyTenno, $Text)
		Status("Script_Info() -> Success")
	Else
		Status("Script_Info() -> Fail")
	EndIf
EndFunc
Func Script_Run()
	$Items = _GuiCtrlListBox_GetItems($ScriptSelected)
	If UBound($Items) <> 0 Then
		ReDim $ScriptID[Ubound($Items)]
		For $i = 0 to Ubound($Items)-1 Step 1
			$Path = @ScriptDir&"\Scripts" & "\" & $Items[$i]
			$ScriptID[$i] = _RunAU3($Path)
			HotKeySet("{F11}")
			HotKeySet("{F11}", "Script_Stop")
		Next
		$ScriptRunning = True
		Status("Script_Run() -> Success")
	Else
		Status("Script_Run() -> Fail")
	EndIf
EndFunc
Func Script_Stop()
	For $i=0 To UBound($ScriptID)-1 Step 1
		ProcessClose($ScriptId[$i])
	Next
	HotKeySet("{F11}")
	HotKeySet("{F11}", "Script_Run")
	$ScriptRunning = False
EndFunc
#EndRegion
#Region Help
Func Help()
	Local $Text = ""
	Switch GuiCtrlRead($HelpTopic)
		Case "Introduction"
			$Text = "LazyTenno is an advanced AutoIt script host aimed at Warframe." & @CRLF & _
					"It comes with lots of pre included scripts, but you can also make" & @CRLF & _
					"your own. The aim of this program is to make botting easier for" & @CRLF & _
					"users without hardware macros." & @CRLF & @CRLF & _
					"This program should not get you banned by DE, but if it ever" & @CRLF & _
					"happens, please keep in mind that you are using it ON YOUR" & @CRLF & _
					"OWN RISK." & @CRLF & @CRLF & _
					"If you have any complaints or bugs, feel free to report them in" & @CRLF & _
					"release thread. Script requests will most likely be ignored. If" & @CRLF & _
					"you need a specific script, try making it yourself in AutoIt." & @CRLF & @CRLF & _
					"THIS program is free of any malicious code! We have been" & @CRLF & _
					"coding bots for over 5 years, and we can guarantee you this" & @CRLF & _
					"program wont infect your PC." & @CRLF & @CRLF & _
					"Happy power leveling!!!"
		Case "How to use"
			$Text = "It is very simple." & @CRLF & @CRLF & _
					"You just select the scripts you want to use and hit the F11" & @CRLF & _
					"hotkey. The scripts are now executed." & @CRLF & @CRLF & _
					"To stop the bots, press the F11 hotkey again." & @CRLF & @CRLF & _
					"If you find any of the bots made by (Desy, Farming Inc, Blacklisted" & @CRLF & _
					"buggy, please report it as a bug in release thread."
		Case "Scripting"
			$Text = "Scripting is done in AutoIt v3. They are mostly the same to Au3" & @CRLF & _
					"but there are a few limitations. You cant use external includes," & @CRLF & _
					"and keeping the script as simple as it can be is advisable." & @CRLF & @CRLF & _
					"You can write .au3 scripts with Notepad, but it is recomended" & @CRLF & _
					"that you download and install AutoIt with its editor, as it comes" & @CRLF & _
					"with amazing documentation and code completion."
		Case Else
			$Text = ""
	EndSwitch
	GuiCtrlSetData($HelpText,$Text)
	Status("Help() -> Success")
EndFunc
#EndRegion
#Region Includes
Func _FileListToArray($sFilePath, $sFilter = "*", $iFlag = 0, $bReturnPath = False)
	Local $sDelimiter = "|", $sFileList = "", $sFileName = "", $sFullPath = ""
	$sFilePath = StringRegExpReplace($sFilePath, "[\\/]+$", "") & "\"
	If $iFlag = Default Then $iFlag = 0
	If $bReturnPath Then $sFullPath = $sFilePath
	If $sFilter = Default Then $sFilter = "*"
	If Not FileExists($sFilePath) Then Return SetError(1, 0, 0)
	If StringRegExp($sFilter, "[\\/:><\|]|(?s)^\s*$") Then Return SetError(2, 0, 0)
	If Not ($iFlag = 0 Or $iFlag = 1 Or $iFlag = 2) Then Return SetError(3, 0, 0)
	Local $hSearch = FileFindFirstFile($sFilePath & $sFilter)
	If @error Then Return SetError(4, 0, 0)
	While 1
		$sFileName = FileFindNextFile($hSearch)
		If @error Then ExitLoop
		If ($iFlag + @extended = 2) Then ContinueLoop
		$sFileList &= $sDelimiter & $sFullPath & $sFileName
	WEnd
	FileClose($hSearch)
	If $sFileList = "" Then Return SetError(4, 0, 0)
	Return StringSplit(StringTrimLeft($sFileList, 1), $sDelimiter)
EndFunc   ;==>_FileListToArray
Func _StringBetween($sString, $sStart, $sEnd, $iMode = 0, $bCase = False)
	$sStart = $sStart ? "\Q" & $sStart & "\E" : "\A"
	If $iMode <> 1 Then $iMode = 0
	If $iMode = 0 Then
		$sEnd = $sEnd ? "(?=\Q" & $sEnd & "\E)" : "\z"
	Else
		$sEnd = $sEnd ? "\Q" & $sEnd & "\E" : "\z"
	EndIf
	If $bCase = Default Then
		$bCase = False
	EndIf
	Local $aReturn = StringRegExp($sString, "(?s" & (Not $bCase ? "i" : "") & ")" & $sStart & "(.*?)" & $sEnd, 3)
	If @error Then Return SetError(1, 0, 0)
	Return $aReturn
EndFunc   ;==>_StringBetween
Func _GuiCtrlListBox_GetItems($CtrlID)
	Local $Items[_GUICtrlListBox_GetCount($CtrlID)]
	For $i = 0 To UBound($Items)-1 Step 1
		$Items[$i] = _GuiCtrlListBox_GetText($CtrlID, $i)
	Next
	Return $Items
EndFunc
Func _RunAU3($sFilePath, $sWorkingDir = "", $iShowFlag = @SW_SHOW, $iOptFlag = 0)
    Return Run('"' & @AutoItExe & '" /AutoIt3ExecuteScript "' & $sFilePath & '"', $sWorkingDir, $iShowFlag, $iOptFlag)
EndFunc   ;==>_RunAU3
Func _GUICtrlListBox_FindString($hWnd, $sText, $bExact = False)
	If Not IsString($sText) Then $sText = String($sText)

	If IsHWnd($hWnd) Then
		If ($bExact) Then
			Return _SendMessage($hWnd, 0x01A2, -1, $sText, 0, "wparam", "wstr")
		Else
			Return _SendMessage($hWnd, 0x018F, -1, $sText, 0, "wparam", "wstr")
		EndIf
	Else
		If ($bExact) Then
			Return GUICtrlSendMsg($hWnd, 0x01A2, -1, $sText)
		Else
			Return GUICtrlSendMsg($hWnd, 0x018F, -1, $sText)
		EndIf
	EndIf
EndFunc   ;==>_GUICtrlListBox_FindString
Func _GUICtrlListBox_DeleteString($hWnd, $iIndex)
	If IsHWnd($hWnd) Then
		Return _SendMessage($hWnd, 0x0182, $iIndex)
	Else
		Return GUICtrlSendMsg($hWnd, 0x0182, $iIndex, 0)
	EndIf
EndFunc
Func _GUICtrlListBox_GetCount($hWnd)
	If IsHWnd($hWnd) Then
		Return _SendMessage($hWnd, 0x018B)
	Else
		Return GUICtrlSendMsg($hWnd, 0x018B, 0, 0)
	EndIf
EndFunc
Func _GUICtrlListBox_GetText($hWnd, $iIndex)
	Local $tText = DllStructCreate("wchar Text[" & _GUICtrlListBox_GetTextLen($hWnd, $iIndex) + 1 & "]")
	If Not IsHWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)
	_SendMessage($hWnd, 0x0189, $iIndex, $tText, 0, "wparam", "struct*")
	Return DllStructGetData($tText, "Text")
EndFunc
Func _GUICtrlListBox_GetTextLen($hWnd, $iIndex)
	If IsHWnd($hWnd) Then
		Return _SendMessage($hWnd, 0x018A, $iIndex)
	Else
		Return GUICtrlSendMsg($hWnd, 0x018A, $iIndex, 0)
	EndIf
EndFunc
Func _SendMessage($hWnd, $iMsg, $wParam = 0, $lParam = 0, $iReturn = 0, $wParamType = "wparam", $lParamType = "lparam", $sReturnType = "lresult")
	Local $aResult = DllCall("user32.dll", $sReturnType, "SendMessageW", "hwnd", $hWnd, "uint", $iMsg, $wParamType, $wParam, $lParamType, $lParam)
	If @error Then Return SetError(@error, @extended, "")
	If $iReturn >= 0 And $iReturn <= 4 Then Return $aResult[$iReturn]
	Return $aResult
EndFunc
#EndRegion