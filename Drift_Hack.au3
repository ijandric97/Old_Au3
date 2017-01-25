#NoTrayIcon
#RequireAdmin
#Region
#AutoIt3Wrapper_Icon=need_for_speed_world.ico
#AutoIt3Wrapper_UseUpx=y
#AutoIt3Wrapper_Res_Description=NFS World - Drag Bot"
#AutoIt3Wrapper_Res_Fileversion=3.0.0.0
#AutoIt3Wrapper_Res_LegalCopyright=©2014 Malware442 All Rights Reserved.
#AutoIt3Wrapper_Run_Tidy=y
#AutoIt3Wrapper_Run_Au3Stripper=y
#EndRegion
Global Const $gui_show = 16
Global Const $gui_hide = 32
Global Const $gui_disable = 128
Global Const $gui_checked = 1
Global Const $gui_unchecked = 4
Global Const $gui_bkcolor_transparent = + -2
Global Const $gui_bkcolor_lv_alternate = + -33554432
Global Const $ws_ex_transparent = 32
Global Const $mem_commit = 4096
Global Const $page_execute_readwrite = 64
Global Const $mem_decommit = 16384
Global $allocatedaddr = 0
HotKeySet("{q}", "DriftON")

#Region DriftGUI
$DriftGUI = GUICreate("Drift", 138, 51, -1, -1, -1, BitOR(0x00040000, 0x00000080))
$DriftStart = GUICtrlCreateButton("Start/Q", 2, 2, 60, 46)
$DriftStop = GUICtrlCreateButton("Stop/Q", 2, 2, 60, 46)
GUICtrlSetState(-1, $gui_hide)
$MaxSpeed = GUICtrlCreateCheckbox("Max Speed", 64, 2, 70, 20)
GUICtrlSetState(-1, $gui_unchecked)
$DriftInfo = GUICtrlCreateLabel("", 64, 22, 70, 20)
GUISetState(@SW_SHOW)
#EndRegion DriftGUI

While 1
	Switch GUIGetMsg()
		Case -3
			Wallhack("OFF")
			Speedhack("OFF")
			Handling(True, 1)
			Exit
		Case $DriftStart
			DriftON()
		Case $DriftStop
			DriftOFF()
	EndSwitch
WEnd

#Region GUI Functions
Func DriftON()
	HotKeySet("{q}", "DriftOFF")
	GUICtrlSetState($DriftStart, $gui_hide)
	GUICtrlSetState($DriftStop, $gui_show)
	GUICtrlSetData($DriftInfo, "DRIFT ON")
	GUICtrlSetColor($DriftInfo, 0x008000)
	Anticheat()
	Sleep(100)
	Wallhack("ON")
	Sleep(100)
	Handling(True, 0.3)
	If GUICtrlRead($MaxSpeed) = 1 Then
		Speedhack("ON")
	EndIf
EndFunc   ;==>DriftON

Func DriftOFF()
	HotKeySet("{q}", "DriftON")
	GUICtrlSetState($DriftStop, $gui_hide)
	GUICtrlSetState($DriftStart, $gui_show)
	GUICtrlSetState($MaxSpeed, $gui_unchecked)
	GUICtrlSetData($DriftInfo, "DRIFT OFF")
	GUICtrlSetColor($DriftInfo, 0xFF0000)
	Wallhack("OFF")
	Speedhack("OFF")
	Handling(True, 1)
EndFunc   ;==>DriftOFF
#EndRegion GUI Functions

#Region Cheats
Func Anticheat()
	$PID = WinGetProcess("NEED FOR SPEED™ WORLD", "")
	$SPID = WinGetProcess("[REGEXPCLASS:Sandbox:(.*?):GameFrame]", "")
	$MemOpen = _MemoryOpen($PID)
	$SMemOpen = _MemoryOpen($SPID)
	$Module = "nfsw.exe"
	$Offset = _StringEncrypt(0, "9B944481C0914D3B1790D3F9E1EA6A7D", $gui_bkcolor_lv_alternate, 1)
	$Offset2 = _StringEncrypt(0, "9B944481C0914D381691AFFEE1ED6A01", $gui_bkcolor_lv_alternate, 1)
	$Offset3 = _StringEncrypt(0, "9B944481C0914D3B1790AFF9E6936A71", $gui_bkcolor_lv_alternate, 1)
	$Offset4 = _StringEncrypt(0, "9B944481C091333B1797AFFEE1E96A01", $gui_bkcolor_lv_alternate, 1)
	$BaseAddress = _MemoryModuleGetBaseAddress($PID, $Module) + $Offset
	$BaseAddress2 = _MemoryModuleGetBaseAddress($PID, $Module) + $Offset2
	$BaseAddress3 = _MemoryModuleGetBaseAddress($PID, $Module) + $Offset3
	$BaseAddress4 = _MemoryModuleGetBaseAddress($PID, $Module) + $Offset4
	$SBaseAddressess = _MemoryModuleGetBaseAddress($SPID, $Module) + $Offset
	$SBaseAddressess2 = _MemoryModuleGetBaseAddress($SPID, $Module) + $Offset2
	$SBaseAddressess3 = _MemoryModuleGetBaseAddress($SPID, $Module) + $Offset3
	$SBaseAddressess4 = _MemoryModuleGetBaseAddress($SPID, $Module) + $Offset4
	_MemoryWrite($BaseAddress, $MemOpen, "3074689515", "long")
	_MemoryWrite($BaseAddress2, $MemOpen, "267160515", "long")
	_MemoryWrite($BaseAddress3, $MemOpen, "1166769387", "long")
	_MemoryWrite($BaseAddress4, $MemOpen, "432259123", "long")
	_MemoryWrite($SBaseAddressess, $SMemOpen, "3074689515", "long")
	_MemoryWrite($SBaseAddressess2, $SMemOpen, "267160515", "long")
	_MemoryWrite($SBaseAddressess3, $SMemOpen, "1166769387", "long")
	_MemoryWrite($SBaseAddressess4, $SMemOpen, "432259123", "long")
	_MemoryClose($MemOpen)
EndFunc   ;==>Anticheat

Func Wallhack($Mode = "OFF")
	$PID = WinGetProcess("NEED FOR SPEED™ WORLD", "")
	$SPID = WinGetProcess("[REGEXPCLASS:Sandbox:(.*?):GameFrame]", "")
	$MemOpen = _MemoryOpen($PID)
	$SMemOpen = _MemoryOpen($SPID)
	$Module = "nfsw.exe"
	$Offset = _StringEncrypt(0, "9B944481C0974D3A1691D3FAE1926D06", $gui_bkcolor_lv_alternate, 1)
	$BaseAddressess = _MemoryModuleGetBaseAddress($PID, $Module) + $Offset
	$SBaseAddressess = _MemoryModuleGetBaseAddress($SPID, $Module) + $Offset
	If $Mode = "ON" Then
		_MemoryWrite($BaseAddressess, $MemOpen, "1427116019", "long")
		_MemoryWrite($SBaseAddressess, $SMemOpen, "1427116019", "long")
		_MemoryClose($MemOpen)
	Else
		_MemoryWrite($BaseAddressess, $MemOpen, "1158680563", "long")
		_MemoryWrite($SBaseAddressess, $SMemOpen, "1158680563", "long")
		_MemoryClose($MemOpen)
	EndIf
EndFunc   ;==>Wallhack

Func Speedhack($Mode = "OFF")
	$PID = WinGetProcess("NEED FOR SPEED™ WORLD", "")
	$SPID = WinGetProcess("[REGEXPCLASS:Sandbox:(.*?):GameFrame]", "")
	$MemOpen = _MemoryOpen($PID)
	$SMemOpen = _MemoryOpen($SPID)
	$Module = "nfsw.exe"
	$Offset = _StringEncrypt(0, "9B944481C0974D3C17E4AFF9E1EE6D7D", $gui_bkcolor_lv_alternate, 1)
	$BaseAddress = _MemoryModuleGetBaseAddress($PID, $Module) + $Offset
	$SBaseAddressess = _MemoryModuleGetBaseAddress($SPID, $Module) + $Offset
	If $Mode = "ON" Then
		_MemoryWrite($BaseAddress, $MemOpen, "772749684", "long")
		_MemoryWrite($SBaseAddressess, $SMemOpen, "772749684", "long")
		_MemoryClose($MemOpen)
	Else
		_MemoryWrite($BaseAddress, $MemOpen, "772749686", "long")
		_MemoryWrite($SBaseAddressess, $SMemOpen, "772749686", "long")
		_MemoryClose($MemOpen)
	EndIf
EndFunc   ;==>Speedhack

Func Handling($toggle = True, $modifier = 10)
	If ProcessExists("nfsw.exe") Then
		$PID = ProcessExists("nfsw.exe")
		$memoryaccess = _MemoryOpen($PID)
		$BaseAddressess = _MemoryModuleGetBaseAddress($PID, "nfsw.exe")
		$address = $BaseAddressess + 4489864
		Switch $toggle
			Case True
				If $allocatedaddr <> 0 Then _MemoryVirtualFreeEx($memoryaccess[1], $allocatedaddr, 128, $mem_decommit)
				$allocatedaddr = _MemoryVirtualAllocEx($memoryaccess[1], 0, 128, $mem_commit, $page_execute_readwrite)
				_WriteFloat($memoryaccess, $allocatedaddr, $modifier)
				$allocatedaddr = Hex($allocatedaddr)
				$allocatedaddr = (StringRight($allocatedaddr, 2) & StringMid($allocatedaddr, 5, 2) & StringMid($allocatedaddr, 3, 2) & StringLeft($allocatedaddr, 2))
				_WriteBytes($memoryaccess, ($address + 3), "05")
				_WriteBytes($memoryaccess, ($address + 4), $allocatedaddr)
			Case False
				_WriteBytes($memoryaccess, ($address + 3), "86 E4 00 00 00")
				_WriteBytes($memoryaccess, ($address + 7), "F3 0F 59 86")
				If $allocatedaddr <> 0 Then _MemoryVirtualFreeEx($memoryaccess[1], $allocatedaddr, 128, $mem_decommit)
		EndSwitch
		_MemoryClose($memoryaccess)
	EndIf
EndFunc   ;==>Handling
#EndRegion Cheats

#Region Other
Func _StringEncrypt($i_encrypt, $s_encrypttext, $s_encryptpassword, $i_encryptlevel = 1)
	If $i_encrypt <> 0 And $i_encrypt <> 1 Then
		SetError(1, 0, "")
	ElseIf $s_encrypttext = "" Or $s_encryptpassword = "" Then
		SetError(1, 0, "")
	Else
		If Number($i_encryptlevel) <= 0 Or Int($i_encryptlevel) <> $i_encryptlevel Then $i_encryptlevel = 1
		Local $v_encryptmodified
		Local $i_encryptcounth
		Local $i_encryptcountg
		Local $v_encryptswap
		Local $av_encryptbox[256][2]
		Local $i_encryptcounta
		Local $i_encryptcountb
		Local $i_encryptcountc
		Local $i_encryptcountd
		Local $i_encryptcounte
		Local $v_encryptcipher
		Local $v_encryptcipherby
		If $i_encrypt = 1 Then
			For $i_encryptcountf = 0 To $i_encryptlevel Step 1
				$i_encryptcountg = ""
				$i_encryptcounth = ""
				$v_encryptmodified = ""
				For $i_encryptcountg = 1 To StringLen($s_encrypttext)
					If $i_encryptcounth = StringLen($s_encryptpassword) Then
						$i_encryptcounth = 1
					Else
						$i_encryptcounth += 1
					EndIf
					$v_encryptmodified = $v_encryptmodified & Chr(BitXOR(Asc(StringMid($s_encrypttext, $i_encryptcountg, 1)), Asc(StringMid($s_encryptpassword, $i_encryptcounth, 1)), 255))
				Next
				$s_encrypttext = $v_encryptmodified
				$i_encryptcounta = ""
				$i_encryptcountb = 0
				$i_encryptcountc = ""
				$i_encryptcountd = ""
				$i_encryptcounte = ""
				$v_encryptcipherby = ""
				$v_encryptcipher = ""
				$v_encryptswap = ""
				$av_encryptbox = ""
				Local $av_encryptbox[256][2]
				For $i_encryptcounta = 0 To 255
					$av_encryptbox[$i_encryptcounta][1] = Asc(StringMid($s_encryptpassword, Mod($i_encryptcounta, StringLen($s_encryptpassword)) + 1, 1))
					$av_encryptbox[$i_encryptcounta][0] = $i_encryptcounta
				Next
				For $i_encryptcounta = 0 To 255
					$i_encryptcountb = Mod(($i_encryptcountb + $av_encryptbox[$i_encryptcounta][0] + $av_encryptbox[$i_encryptcounta][1]), 256)
					$v_encryptswap = $av_encryptbox[$i_encryptcounta][0]
					$av_encryptbox[$i_encryptcounta][0] = $av_encryptbox[$i_encryptcountb][0]
					$av_encryptbox[$i_encryptcountb][0] = $v_encryptswap
				Next
				For $i_encryptcounta = 1 To StringLen($s_encrypttext)
					$i_encryptcountc = Mod(($i_encryptcountc + 1), 256)
					$i_encryptcountd = Mod(($i_encryptcountd + $av_encryptbox[$i_encryptcountc][0]), 256)
					$i_encryptcounte = $av_encryptbox[Mod(($av_encryptbox[$i_encryptcountc][0] + $av_encryptbox[$i_encryptcountd][0]), 256)][0]
					$v_encryptcipherby = BitXOR(Asc(StringMid($s_encrypttext, $i_encryptcounta, 1)), $i_encryptcounte)
					$v_encryptcipher &= Hex($v_encryptcipherby, 2)
				Next
				$s_encrypttext = $v_encryptcipher
			Next
		Else
			For $i_encryptcountf = 0 To $i_encryptlevel Step 1
				$i_encryptcountb = 0
				$i_encryptcountc = ""
				$i_encryptcountd = ""
				$i_encryptcounte = ""
				$v_encryptcipherby = ""
				$v_encryptcipher = ""
				$v_encryptswap = ""
				$av_encryptbox = ""
				Local $av_encryptbox[256][2]
				For $i_encryptcounta = 0 To 255
					$av_encryptbox[$i_encryptcounta][1] = Asc(StringMid($s_encryptpassword, Mod($i_encryptcounta, StringLen($s_encryptpassword)) + 1, 1))
					$av_encryptbox[$i_encryptcounta][0] = $i_encryptcounta
				Next
				For $i_encryptcounta = 0 To 255
					$i_encryptcountb = Mod(($i_encryptcountb + $av_encryptbox[$i_encryptcounta][0] + $av_encryptbox[$i_encryptcounta][1]), 256)
					$v_encryptswap = $av_encryptbox[$i_encryptcounta][0]
					$av_encryptbox[$i_encryptcounta][0] = $av_encryptbox[$i_encryptcountb][0]
					$av_encryptbox[$i_encryptcountb][0] = $v_encryptswap
				Next
				For $i_encryptcounta = 1 To StringLen($s_encrypttext) Step 2
					$i_encryptcountc = Mod(($i_encryptcountc + 1), 256)
					$i_encryptcountd = Mod(($i_encryptcountd + $av_encryptbox[$i_encryptcountc][0]), 256)
					$i_encryptcounte = $av_encryptbox[Mod(($av_encryptbox[$i_encryptcountc][0] + $av_encryptbox[$i_encryptcountd][0]), 256)][0]
					$v_encryptcipherby = BitXOR(Dec(StringMid($s_encrypttext, $i_encryptcounta, 2)), $i_encryptcounte)
					$v_encryptcipher = $v_encryptcipher & Chr($v_encryptcipherby)
				Next
				$s_encrypttext = $v_encryptcipher
				$i_encryptcountg = ""
				$i_encryptcounth = ""
				$v_encryptmodified = ""
				For $i_encryptcountg = 1 To StringLen($s_encrypttext)
					If $i_encryptcounth = StringLen($s_encryptpassword) Then
						$i_encryptcounth = 1
					Else
						$i_encryptcounth += 1
					EndIf
					$v_encryptmodified &= Chr(BitXOR(Asc(StringMid($s_encrypttext, $i_encryptcountg, 1)), Asc(StringMid($s_encryptpassword, $i_encryptcounth, 1)), 255))
				Next
				$s_encrypttext = $v_encryptmodified
			Next
		EndIf
		Return $s_encrypttext
	EndIf
EndFunc   ;==>_StringEncrypt

Func _MemoryModuleGetBaseAddress($PID, $Module)
	If Not ProcessExists($PID) Then Return SetError(1, 0, 0)
	If Not IsString($Module) Then Return SetError(2, 0, 0)
	Local $psapi = DllOpen("psapi.dll")
	Local $hprocess
	Local $permission = BitOR(2, 1024, 8, 16, 32)
	If $PID > 0 Then
		Local $hprocess = DllCall("kernel32.dll", "ptr", "OpenProcess", "dword", $permission, "int", 0, "dword", $PID)
		If $hprocess[0] Then
			$hprocess = $hprocess[0]
		EndIf
	EndIf
	Local $modules = DllStructCreate("ptr[1024]")
	Local $acall = DllCall($psapi, "int", "EnumProcesModules", "ptr", $hprocess, "ptr", DllStructGetPtr($modules), "dword", DllStructGetSize($modules), "dword*", 0)
	If $acall[4] > 0 Then
		Local $imodnum = $acall[4] / 4
		Local $atemp
		For $i = 1 To $imodnum
			$atemp = DllCall($psapi, "dword", "GetModuleBaseNameW", "ptr", $hprocess, "ptr", Ptr(DllStructGetData($modules, 1, $i)), "wstr", "", "dword", 260)
			If $atemp[3] = $Module Then
				DllClose($psapi)
				Return Ptr(DllStructGetData($modules, 1, $i))
			EndIf
		Next
	EndIf
	DllClose($psapi)
	Return SetError(+ -1, 0, 0)
EndFunc   ;==>_MemoryModuleGetBaseAddress

Func _MemoryOpen($iv_pid, $iv_desiredaccess = 2035711, $if_inherithandle = 1)
	If Not ProcessExists($iv_pid) Then
		SetError(1)
		Return 0
	EndIf
	Local $ah_handle[2] = [DllOpen("kernel32.dll")]
	If @error Then
		SetError(2)
		Return 0
	EndIf
	Local $av_openprocess = DllCall($ah_handle[0], "int", "OpenProcess", "int", $iv_desiredaccess, "int", $if_inherithandle, "int", $iv_pid)
	If @error Then
		DllClose($ah_handle[0])
		SetError(3)
		Return 0
	EndIf
	$ah_handle[1] = $av_openprocess[0]
	Return $ah_handle
EndFunc   ;==>_MemoryOpen

Func _MemoryWrite($iv_address, $ah_handle, $v_data, $sv_type = "dword")
	If Not IsArray($ah_handle) Then
		SetError(1)
		Return 0
	EndIf
	Local $v_buffer = DllStructCreate($sv_type)
	If @error Then
		SetError(@error + 1)
		Return 0
	Else
		DllStructSetData($v_buffer, 1, $v_data)
		If @error Then
			SetError(6)
			Return 0
		EndIf
	EndIf
	DllCall($ah_handle[0], "int", "WriteProcessMemory", "int", $ah_handle[1], "int", $iv_address, "ptr", DllStructGetPtr($v_buffer), "int", DllStructGetSize($v_buffer), "int", "")
	If Not @error Then
		Return 1
	Else
		SetError(7)
		Return 0
	EndIf
EndFunc   ;==>_MemoryWrite

Func _MemoryClose($ah_handle)
	If Not IsArray($ah_handle) Then
		SetError(1)
		Return 0
	EndIf
	DllCall($ah_handle[0], "int", "CloseHandle", "int", $ah_handle[1])
	If Not @error Then
		DllClose($ah_handle[0])
		Return 1
	Else
		DllClose($ah_handle[0])
		SetError(2)
		Return 0
	EndIf
EndFunc   ;==>_MemoryClose

Func _MemoryVirtualAllocEx($hprocess, $paddress, $isize, $iallocation, $iprotect)
	Local $aresult
	$aresult = DllCall("kernel32.dll", "ptr", "VirtualAllocEx", "handle", $hprocess, "ptr", $paddress, "ulong_ptr", $isize, "dword", $iallocation, "dword", $iprotect)
	Return $aresult[0]
EndFunc   ;==>_MemoryVirtualAllocEx

Func _MemoryVirtualFreeEx($hprocess, $paddress, $isize, $ifreetype)
	Local $aresult
	$aresult = DllCall("kernel32.dll", "bool", "VirtualFreeEx", "handle", $hprocess, "ptr", $paddress, "ulong_ptr", $isize, "dword", $ifreetype)
	Return $aresult[0]
EndFunc   ;==>_MemoryVirtualFreeEx

Func _WriteBytes($handle, $addr, $bytes)
	$bytes = StringRegExp($bytes, "([[:xdigit:]]{2})", 3)
	$sret = ""
	For $i = UBound($bytes) + -1 To 0 Step + -1
		$sret &= $bytes[$i]
	Next
	$bytes = Dec($sret)
	$buffer = DllStructCreate("long")
	DllStructSetData($buffer, 1, $bytes)
	DllCall($handle[0], "int", "WriteProcessMemory", "int", $handle[1], "int", $addr, "ptr", DllStructGetPtr($buffer), "int", DllStructGetSize($buffer), "int", "")
EndFunc   ;==>_WriteBytes

Func _WriteFloat($handle, $addr, $value)
	Local $float = DllStructCreate("float")
	DllStructSetData($float, 1, $value)
	DllCall("kernel32.dll", "int", "WriteProcessMemory", "int", $handle[1], "int", $addr, "ptr", DllStructGetPtr($float), "int", 4, "int", 0)
EndFunc   ;==>_WriteFloat
#EndRegion Other
