; #FUNCTION# ====================================================================================================================
; Name ..........: GETLIST
; Description ...: Downloads .ini file, then reads it on fly, and returns the requested string
; Syntax ........: GETLIST($CURL, $CDIR, $CPATH, $PASS, $LVL, $SECTION, $KEY)
; Parameters ....: $CURL                - Url to .ini file (it must be crypted)
;                  $CDIR                - Dir in which .ini will be saved (it must be crypted, its not full path,
;										  so its not /something/downloaded.ini, its /something (just an example))
;                  $CPATH               - Full path to save location (it must be crypted, this is not directory,
;										  so its not /something, its /something/downloaded.ini (just an example))
;                  $PASS                - Decrypt passkey (menas that all of strings have to be crypted using same key)
;                  $LVL                 - Crypt lvl (all of them need to have same crypt lvl)
;                  $SECTION             - Which section from ini to red
;                  $KEY                 - Which line from that section
; Return values .: On sucess = the requested string
;				   On error  = 0 (url cant be decrypted)
;							   1 (dir cant be decrypted)
;							   2 (path cant be decrypted)
;							   3 (download dir doesnt exist / cant be created)
;							   4 (file isnt downloaded)
;							   5 (cant read from ini)
; Author ........: Desynchronised
; Modified ......: 13.12.2012.
; Remarks .......: All of strings (e.g. $CURL, $CDIR, $CPATH) have to be crypted with _StringEncrypt, they have to be crypted
;				   with same passkey and lvl
; Related .......: _StringEncrypt, InetGet, DirCreate, FileExists, IniRead
; Example .......: No
; ===============================================================================================================================
Func GETLIST($CURL, $CDIR, $CPATH, $PASS, $LVL, $SECTION, $KEY)
	$URL = _StringEncrypt(0, $CURL, $PASS, $LVL)
	If @error Then
		SetError(0)
	EndIf
	$DIR = _StringEncrypt(0, $CDIR, $PASS, $LVL)
	If @error Then
		SetError(1)
	EndIf
	$PATH = _StringEncrypt(0, $CPATH, $PASS, $LVL)
	If @error Then
		SetError(2)
	EndIf
	If FileExists($DIR) = 0 Then
		DirCreate($DIR)
	Else
		SetError(3)
	EndIf
	InetGet($URL, $PATH)
	If FileExists($PATH) = 0 Then
		SetError(4)
	EndIf
	$CCHEATS = IniRead($PATH, $SECTION, $KEY, 0)
	Return $CCHEATS
	If @error Then
		SetError(5)
	EndIf
EndFunc   ;==>GETLIST
; #FUNCTION# ====================================================================================================================
; Name ..........: GETCHEAT
; Description ...: Splits string returned by GETLIST to crypted substrings, then decrypts the substring and returns it.
; Syntax ........: GETCHEAT($CCHEATS, $DELIMITER, $R, $PASS, $LVL)
; Parameters ....: $CCHEATS             - String returned by GETLIST
;                  $DELIMITER           - Delimiter word thats used to split string on substrings
;                  $R                   - Substring to read (1st substring = 0)
;                  $PASS                - passkey for decryotng substrings
;                  $LVL                 - lvl for decrypting substrings
; Return values .: On sucess = requested string
;				   On error = 1 (given string cant be split)
;							  2 (cant read substring)
;							  3 (cant decrypt substring)
; Author ........: Desynchronised
; Modified ......: 13.12.2012.
; Remarks .......: You can't use multiple delimiters!!! (you can, but dont complicate simple things, cause its not bug proof)
;				   You must use GETLIST first!!! Using same passkey for all encrypted substrings is the best way, but you can
;				   use multiple ones if you want. Using same encryption lvl for all encrypted substring is best way, but you can
;				   use multiple lvls if you want (but it might slow down the script).
; Related .......: _StringExplode, _ArrayDisplay, _StringEncrypt
; Example .......: No
; ===============================================================================================================================
Func GETCHEAT($CCHEATS, $DELIMITER, $R, $PASS, $LVL)
	Local $CHEATS = _StringExplode($CCHEATS, $DELIMITER)
	If @error Then
		SetError(1)
	EndIf
	$CRETURN = $CHEATS[$R]
	If @error Then
		SetError(2)
	EndIf
	$RETURN = _StringEncrypt(0, $CRETURN, $PASS, $LVL)
	Return $RETURN
	If @error Then
		SetError(3)
	EndIf
EndFunc   ;==>GETCHEAT
; #FUNCTION# ====================================================================================================================
; Name ..........: GETDESTROY
; Description ...: Destroys the .ini file created by GETLIST.
; Syntax ........: GETDESTROY($CDIR, $PASS, $LVL, $CFURL, $CPATH)
; Parameters ....: $CDIR                - Dir in which .ini was saved (it must be crypted, its not full path,
;										  so its not /something/downloaded.ini, its /something (just an example), it must
;										  be same as its in GETLIST, or youll delete wrong directory!!!)
;                  $PASS                - passkey for decrypted strings (again same as for GETLIST)
;                  $LVL                 - encryption lvl (use the one you use in GETLIST)
;                  $CFURL               - [OPTIONAL] If direremove fail, itll download fake .ini (which contains wrong stuff,
;										  then itll replace it with the one that exists)
;                  $CPATH               - [OPTIONAL] Where to download fake .ini, must be same as for original .ini (so its
;										  same as in GETLIST)
; Return values .: On error = 0 (cant decrypt directory name)
;							= 1 (cant decrypt fake url name)
; Author ........: Desynchronised
; Modified ......: 13.12.2012.
; Remarks .......: Same as for the GETLIST
; Related .......: _StringEncrypt, DirRemove, InetGet
; Example .......: No
; ===============================================================================================================================
Func GETDESTROY($CDIR, $PASS, $LVL, $CFURL, $CPATH,)
	$DIR = _StringEncrypt(0, $CPATH, $PASS, $LVL)
	If @error Then
		SetError(0)
	EndIf
	DirRemove($DIR, 1)
	If FileExists($PATH) = 1 Then
		$URL = _StringEncrypt(0, $FURL, $PASS, $LVL)
		If @error Then
			SetError(1)
		EndIf
		InetGet($FURL, $CPATH)
	EndIf
EndFunc   ;==>GETDESTROY
; #FUNCTION# ====================================================================================================================
; Name ..........: _PIDSPLIT
; Description ...: Used for obtaining PID's of both game instances, if 2 instances are found.
; Syntax ........: _PIDSPLIT($process, $id, $pemode)
; Parameters ....: $process             - Name of process to search pids for, example. "gamestart.exe"
;                  $id                  - Which pid to return. If 1 then return PID of first instance, If 2 then return PID
;										  of second instance. In most cases second instance is PID of sandboxed game.
;                  $pemode              - How to react if process not found. If 0 then stop func and set error, if 1 wait till
;										  process is found.
; Return values .: On sucess			- Returns PID of given process
;				   On fail				- Returns 0 and @error
;				   @error 				- 1 = Process not found
;										- 2 = Process found, but cant obtain PID
; Author ........: Desynchronised
; Modified ......: 27.11.2012.
; Remarks .......: This is only tested with sandboxie. Please note, that youll get PID error, if you dont have 2 instances of
;				   same .exe running
; Related .......: _MEMORYMODULEGETBASEADRESS, _MemoryOpen, _MemoryRead, _MemoryWrite, _MemoryClose
; Example .......: No
; ===============================================================================================================================
Func _PIDSPLIT($process, $id, $pemode)
	If ProcessExists($process) = 0 Then
		If $penmode = 0 Then
			SetError(1)
			Return 0
		ElseIf $penmode = 1 Then
			ProcessWait($process)
			Local $list = ProcessList($process)
			Dim $pid1 = $list[1][1]
			Dim $pid2 = $list[2][1]
			If $id = 1 Then
				Return $pid1
			ElseIf $id = 2 Then
				Return $pid2
			ElseIf @error Then
				SetError(2)
			EndIf
		EndIf
	ElseIf ProcessExists($process) = 1 Then
		Local $list = ProcessList($process)
		Dim $pid1 = $list[1][1]
		Dim $pid2 = $list[2][1]
		If $id = 1 Then
			Return $pid1
		ElseIf $id = 2 Then
			Return $pid2
		ElseIf @error Then
			SetError(2)
		EndIf
	EndIf
EndFunc   ;==>_PIDSPLIT