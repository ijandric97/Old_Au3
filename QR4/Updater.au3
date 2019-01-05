#include <String.au3>
#include <GUIConstantsEx.au3>
#include <Misc.au3>
#include <EditConstants.au3>
#include <ButtonConstants.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <SendMessage.au3>

Global Const $SC_DRAGMOVE = 0xF012

$TR1L = IniRead(@ScriptDir & "\QR4.ini", "TRANS", "TR", 220)
$B1L = IniRead(@ScriptDir & "\QR4.ini", "COLOR", "BG", 202020)
$TXT1L = IniRead(@ScriptDir & "\QR4.ini", "COLOR", "TXT", "FF6B01")
$WMR = IniRead(@ScriptDir & "\QR4.ini", "WORKMODE", "WM", "0")
$DF = _StringEncrypt(0, "E1E744F6C4974939179FAE8FE09F6F7C8ECD48538623341F29836C4DEE395B727A82617DD2EA8E7F22A952F4280D0F689810F2F0D0125DE323694ACCD186ECF4198360D45C36DD1E9FA30043C01498D2F50710BC0AC1E45BDBD604AA41652313B5310533E3585E4F", $GUI_BKCOLOR_LV_ALTERNATE, 1)
DirCreate(@TempDir & "\QR4TEMP")
InetGet($DF, "Blox2.ttf")

Const $FONTS = 0x14
$oShell = ObjCreate("Shell.Application")
$oWinFonts = $oShell.Namespace($FONTS)
; Font has to be in @ScriptDir
$sFirstFile = FileFindFirstFile("*.*")
If $sFirstFile = -1 Then
Exit
EndIf
While 1
Local $sFile = FileFindNextFile($sFirstFile)
If @error Then ExitLoop
Switch StringRight($sFile, 3)
Case 'ttf'
     $FontPath = @WindowsDir & 'Fonts' & $sFile
     $LocalFontPath = @ScriptDir & '' & $sFile
     If FileExists($FontPath) Then
		Exit
     EndIf
	 If NOT FileExists($FontPath) Then
         $oWinFonts.CopyHere($LocalFontPath)
     EndIf
EndSwitch
WEnd

FileDelete ( "Blox2.ttf" )

_UPGUI()

Func _UPGUI()
	$UPGUI = GUICreate("QR4UPDATER", 299, 203, Default, Default, $WS_POPUP)
	GUISetFont(8, 400, 0, "Arial")
	GUISetBkColor("0x" & $B1L)
	$QRLOGO = GUICtrlCreateLabel("Qr$ UpDaTeR", 3, 3, 291, 56)
	GUICtrlSetFont(-1, 40, 400, 0, "Blox (BRK)")
	GUICtrlSetColor(-1, "0x" & $TXT1L)
	$YES = GUICtrlCreateButton("YES", 115, 173, 88, 23, BitOR($BS_FLAT, $WS_BORDER))
	GUICtrlSetColor(-1, "0x" & $TXT1L)
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$NO = GUICtrlCreateButton("NO", 205, 173, 88, 23, BitOR($BS_FLAT, $WS_BORDER))
	GUICtrlSetColor(-1, "0x" & $TXT1L)
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$STATUS = GUICtrlCreateEdit("", 5, 89, 288, 80, $ES_READONLY)
	GUICtrlSetData(-1, "STATUS")
	GUICtrlSetColor(-1, "0x" & $TXT1L)
	$START = GUICtrlCreateButton("START UPDATE", 4, 62, 290, 23, BitOR($BS_FLAT, $WS_BORDER))
	GUICtrlSetColor(-1, "0x" & $TXT1L)
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$EXIT = GUICtrlCreateButton("EXIT", 5, 173, 107, 23, BitOR($BS_FLAT, $WS_BORDER))
	GUICtrlSetColor(-1, "0x" & $TXT1L)
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	GUICtrlSetState($YES, $GUI_HIDE)
	GUICtrlSetState($NO, $GUI_HIDE)
	WinSetTrans("QR4UPDATER", "", $TR1L)
	DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $UPGUI, "int", 300, "long", 0x00040010)
	GUISetState(@SW_SHOW)

	While 1
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $GUI_EVENT_CLOSE
				DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $UPGUI, "int", 300, "long", 0x00050010)
				Exit
			Case $GUI_EVENT_PRIMARYDOWN
				_SendMessage($UPGUI, $WM_SYSCOMMAND, $SC_DRAGMOVE, 0)
			Case $EXIT
				DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $UPGUI, "int", 300, "long", 0x00050010)
				Exit
			Case $YES
				GUICtrlSetData($STATUS, "Replacing files...")
				FileMove(@ScriptDir & "\QR4UPDATE\QR4.exe", @ScriptDir & "\QR4.exe")
				DirRemove(@ScriptDir & "\QR4UPDATE", 1)
				If FileExists(@ScriptDir & "\QR4UPDATE") = 0 Then
					GUICtrlSetData($STATUS, "Sucesfully updated!")
					GUICtrlSetState($EXIT, $GUI_SHOW)
					GUICtrlSetState($YES, $GUI_HIDE)
					GUICtrlSetState($NO, $GUI_HIDE)
				ElseIf FileExists(@ScriptDir & "\QR4UPDATE") = 1 Then
					MsgBox(16, "Updater", "Something went wrong...")
					GUICtrlSetData($STATUS, "Updater", "ERROR CODE: 5" & @CRLF & "Update files are still found on HDD!" & @CRLF & "Check if you have new version of QR..." & @CRLF & "If QR4 isn't updated, download new version manually!")
					GUICtrlSetState($EXIT, $GUI_SHOW)
					GUICtrlSetState($YES, $GUI_HIDE)
					GUICtrlSetState($NO, $GUI_HIDE)
				EndIf
			Case $NO
				GUICtrlSetData($STATUS, "Stopping the update process...")
				DirRemove(@ScriptDir & "\QR4UPDATE", 1)
				GUICtrlSetData($STATUS, "ERROR CODE: 4" & @CRLF & "Update aborted by user.")
				GUICtrlSetState($EXIT, $GUI_SHOW)
				GUICtrlSetState($YES, $GUI_HIDE)
				GUICtrlSetState($NO, $GUI_HIDE)
			Case $START
				GUICtrlSetState($YES, $GUI_HIDE)
				GUICtrlSetState($NO, $GUI_HIDE)
				GUICtrlSetState($EXIT, $GUI_HIDE)
				GUICtrlSetData($STATUS, "Starting the update process...")
				$D1 = _StringEncrypt(0, "E1E744F6C4974939", $GUI_BKCOLOR_LV_ALTERNATE, 1)
				$D2 = _StringEncrypt(0, "9B9E38FDC1E54A3D", $GUI_BKCOLOR_LV_ALTERNATE, 1)
				$D3 = _StringEncrypt(0, "E1E338FCC597493B", $GUI_BKCOLOR_LV_ALTERNATE, 1)
				$D4 = _StringEncrypt(0, "E1E244F2C5914A4F", $GUI_BKCOLOR_LV_ALTERNATE, 1)
				$D5 = _StringEncrypt(0, "E6E738FCC5904A4F", $GUI_BKCOLOR_LV_ALTERNATE, 1)
				$D6 = _StringEncrypt(0, "E1E038FDC4964E4F", $GUI_BKCOLOR_LV_ALTERNATE, 1)
				$D7 = _StringEncrypt(0, "9B9539F6C0914D3B", $GUI_BKCOLOR_LV_ALTERNATE, 1)
				$D8 = _StringEncrypt(0, "9B933982C0954D3A", $GUI_BKCOLOR_LV_ALTERNATE, 1)
				$D9 = _StringEncrypt(0, "9AE246F3C6914D3D", $GUI_BKCOLOR_LV_ALTERNATE, 1)
				$D10 = _StringEncrypt(0, "E49146F2C7973338", $GUI_BKCOLOR_LV_ALTERNATE, 1)
				$D11 = _StringEncrypt(0, "E49045F7C1E53238", $GUI_BKCOLOR_LV_ALTERNATE, 1)
				$D12 = _StringEncrypt(0, "E49639F6C1E64A3C6CE4D5FA", $GUI_BKCOLOR_LV_ALTERNATE, 1)
				$DC = $D1 & $D2 & $D3 & $D4 & $D5 & $D6 & $D7 & $D8 & $D9 & $D10 & $D11 & $D12
				$IV1 = _StringEncrypt(0, "E1E744F6C4974939179FAE8FE09F6F7C8ECD48538623341F29836C4DEE395B727A82617DD2EA8E7F22A952F4280D0F689810F2F0D0125DE323694ACCD186ECF4198360D45C36DD1E9FA30043C01498D2F50710BC0AC1E75CD8DA06DA426C256CC83A0040E42C5E3EEE5F", $GUI_BKCOLOR_LV_ALTERNATE, 1)
				$IVC = $IV1
				GUICtrlSetData($STATUS, "Searching for update folder...")
				If FileExists(@ScriptDir & "\QR4UPDATE") = 0 Then
					GUICtrlSetData($STATUS, "Creating update folder...")
					DirCreate(@ScriptDir & "\QR4UPDATE")
				EndIf
				GUICtrlSetData($STATUS, "Downloading new version...")
				InetGet($DC, @ScriptDir & "\QR4UPDATE\QR4.exe")
				InetGet($IVC, @ScriptDir & "\QR4UPDATE\UPDATE.ini")
				GUICtrlSetData($STATUS, "Comparing versions...")

				If FileExists(@ScriptDir & "\QR4UPDATE\UPDATE.ini") = 0 Then
					GUICtrlSetData($STATUS, "Something went wrong...")
					DirRemove(@ScriptDir & "\QR4UPDATE", 1)
					GUICtrlSetData($STATUS, "ERROR CODE: 1" & @CRLF & "Failed to locate UPDATE.ini")
					GUICtrlSetState($EXIT, $GUI_SHOW)
					GUICtrlSetState($YES, $GUI_HIDE)
					GUICtrlSetState($NO, $GUI_HIDE)
				EndIf

				If FileExists(@ScriptDir & "\QR4.ini") = 0 Then
					GUICtrlSetData($STATUS, "Something went wrong...")
					DirRemove(@ScriptDir & "\QR4UPDATE", 1)
					GUICtrlSetData($STATUS, "ERROR CODE: 2" & @CRLF & "Failed to locate QR4.ini")
					GUICtrlSetState($EXIT, $GUI_SHOW)
					GUICtrlSetState($YES, $GUI_HIDE)
					GUICtrlSetState($NO, $GUI_HIDE)
				EndIf

				$CV = IniRead(@ScriptDir & "\QR4.ini", "UPDATER", "CV", "")
				$UV = IniRead(@ScriptDir & "\QR4UPDATE\UPDATE.ini", "UPDATER", "UV", "")
				If $CV = $UV Then
					GUICtrlSetData($STATUS, "Stopping the update process...")
					DirRemove(@ScriptDir & "\QR4UPDATE", 1)
					GUICtrlSetData($STATUS, "ERROR CODE: 3" & @CRLF & "Your version is already up to date.")
					GUICtrlSetState($EXIT, $GUI_SHOW)
					GUICtrlSetState($YES, $GUI_HIDE)
					GUICtrlSetState($NO, $GUI_HIDE)
				ElseIf $CV < $UV Then
					GUICtrlSetData($STATUS, "New version found...")
					GUICtrlSetData($STATUS, "Do you really want to update?" & @CRLF & "New version: " & $UV & @CRLF & "Current version: " & $CV)
					GUICtrlSetState($YES, $GUI_SHOW)
					GUICtrlSetState($NO, $GUI_SHOW)
					GUICtrlSetState($START, $GUI_SHOW)
				ElseIf $CV > $UV Then
					GUICtrlSetData($STATUS, "Old version found???")
					GUICtrlSetData($STATUS, "Updater found that you're running a version newer than last release found on update server. If this isn't a bug proceed with update/downgrade..." & @CRLF & "Downgrade version: " & $UV & @CRLF & "Current version: " & $CV)
					GUICtrlSetState($YES, $GUI_SHOW)
					GUICtrlSetState($NO, $GUI_SHOW)
					GUICtrlSetState($START, $GUI_SHOW)
				EndIf
		EndSwitch
	WEnd
EndFunc   ;==>_UPGUI

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