;DllCall("uxtheme.dll", "none", "SetThemeAppProperties", "int", 0) ; Disable Theming: 0 = all, 1=controls only, 2=border only, 4=webcontent only
Global Const $LVM_SETCOLUMNWIDTH = 4126
Global $Source, $NewsTitle, $NewsLink, $NewsDescription
Global $NewsList[1]

$Main = GUICreate("NFS World News Feed", 474, 346, -1, -1, -1, 262528)
$NewsList[0] = GUICtrlCreateListView("Title|Description", 8, 8, 458, 302, 32773, 66593)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 0, 100)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 1, -2)
$ReadMore = GUICtrlCreateButton("Read full article...", 8, 312, 227, 25)
$Refresh = GuiCtrlCreateButton("Refresh...", 239, 312, 227, 25)
GUISetState(@SW_SHOW)
News_Get()
News_Sort()

While 1
	Switch GUIGetMsg()
		Case -3
			ExitLoop
		Case $Refresh
			News_Clean()
			News_Get()
			News_Sort()
		Case $ReadMore
			$i = GuiCtrlRead($NewsList[0])
			ShellExecute($NewsLink[$i-5])
	EndSwitch
WEnd

#region newsfeed
Func News_Clean()
	For $i=1 to UBound($NewsList)-1 step +1
		GuiCtrlDelete($NewsList[$i])
	Next
EndFunc
Func News_Get($Sort=True)
	$Source = _ANSI2Unicode(_INetGetSource("http://world.needforspeed.com/SpeedAPI/ws/cmsbridge/news/rss/en_US", True)) ; Get news on English
	If $Source <> "" Then ; If function didnt fail
		;First element of array is the general message from server, news start from array element 1
		$NewsTitle = _StringBetween($Source, "<title>", "</title>")
		$NewsLink = _StringBetween($Source, "<link>", "</link>")
		$NewsDescription = _StringBetween($Source, "<description>", "</description>")
	Else
		MsgBox(262144, "NFSW Servers Status", "Unable to contact servers./Servers are down.")
	EndIf
EndFunc
Func News_Sort()
	ReDim $NewsList[UBound($NewsTitle)+1]
	;News start from array element 1, thats why $i = 1
	For $i = 1 to (UBound($NewsTitle)-1) step +1 ;Size is 11, an real news are ten, so Ubound-1
		$NewsList[$i] = GUICtrlCreateListViewItem($NewsTitle[$i]&"|"&$NewsDescription[$i], $NewsList[0])
		;Fix news link, default one doesnt lead to article, instead it leads to all news page
		$NewsLink[$i] = StringReplace($NewsLink[$i],'#','/article/')
	Next
EndFunc
#endregion
#Region functions
Func _INetGetSource($s_url, $bstring = True)
	Local $sstring = InetRead($s_url, 1)
	Local $nerror = @error, $nextended = @extended
	If $bstring Then $sstring = BinaryToString($sstring)
	Return SetError($nerror, $nextended, $sstring)
EndFunc   ;==>_INetGetSource
Func _StringBetween($s_String, $s_Start, $s_End, $v_Case = -1)
	Local $s_case = ""
	If $v_Case = Default Or $v_Case = -1 Then $s_case = "(?i)"
	Local $s_pattern_escape = "(\.|\||\*|\?|\+|\(|\)|\{|\}|\[|\]|\^|\$|\\)"
	$s_Start = StringRegExpReplace($s_Start, $s_pattern_escape, "\\$1")
	$s_End = StringRegExpReplace($s_End, $s_pattern_escape, "\\$1")
	If $s_Start = "" Then $s_Start = "\A"
	If $s_End = "" Then $s_End = "\z"
	Local $a_ret = StringRegExp($s_String, "(?s)" & $s_case & $s_Start & "(.*?)" & $s_End, 3)
	If @error Then Return SetError(1, 0, 0)
	Return $a_ret
EndFunc   ;==>_StringBetween
Func _ANSI2Unicode($sstring = "")
	Local Const $sf_ansi = 1
	Local Const $sf_utf8 = 4
	Return BinaryToString(StringToBinary($sstring, $sf_ansi), $sf_utf8)
EndFunc
#endregion