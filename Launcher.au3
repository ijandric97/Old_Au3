#region Variables
Global $Random = Random(1,9,1) ;Flag1 = Return Int
Global $DriveSerialCode = DriveGetSerial("c:\")
Global $ErrorCode = "Farming Inc."
Global $ErrorHandler
Const $LVM_SETCOLUMNWIDTH = 4126
Global $Source, $Mode
Global $NewsTitle, $NewsLink, $NewsDescription
Global $ShardName, $ShardIp
Global $NewsList[1]
Global $ResourcesPath = "\NFSWLauncher\Resources"
Global $FolderPath = "\NFSWLauncher\"
Global $GameFilePath = "\NFSWLauncher\Resources\GameFile"
Global $GameFile = "GameFile"
Global $GameExe = IniRead(@ProgramFilesDir & $GameFilePath, $GameFile, $GameFile, "")
Global $AppName = "NFS World Launcher"
#endregion

#region Initialization
;Check if folder for storing files exists, and if it doesn't create it
If Not FileExists(@ProgramFilesDir & $ResourcesPath) Then
	DirCreate(@ProgramFilesDir & $ResourcesPath)
EndIf
;Check if launcher knows path for nfsw.exe
If IniRead(@ProgramFilesDir & $GameFilePath, $GameFile, $GameFile, "") = False Then
	$GameExe = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\Electronic Arts\Need For Speed World", "GameInstallDir")
	If Not @error Then
		IniWrite(@ProgramFilesDir & $GameFilePath, $GameFile, $GameFile, $GameExe & "\Data")
	Else
		Game_Directory(False)
	EndIf
EndIf
#endregion Initialization

#region GUI News
$NewsReader = GUICreate("NFS World News Feed", 474, 346, -1, -1, -1, 262528)
$NewsList[0] = GUICtrlCreateListView("Title|Description", 8, 8, 458, 302, 32773, 66593)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 0, 100)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 1, -2)
$ReadMore = GUICtrlCreateButton("Read full article...", 8, 312, 227, 25)
$Refresh = GuiCtrlCreateButton("Refresh...", 239, 312, 227, 25)
#endregion

#region GUI Main
$Launcher = GUICreate($AppName, 162, 303, -1, -1, 524288, 262528)
$FileMenu = GUICtrlCreateMenu("&File")
$FileAdd = GUICtrlCreateMenuItem("Add account", $FileMenu)
$FileRemove = GUICtrlCreateMenuItem("Remove account", $FileMenu)
$FileEdit = GUICtrlCreateMenuItem("Edit account", $FileMenu)
$ToolsMenu = GUICtrlCreateMenu("Tools")
$ToolsRefreshAccount = GUICtrlCreateMenuItem("Refresh account list", $ToolsMenu)
$ToolsRefreshShards = GUICtrlCreateMenuItem("Refresh shard list", $ToolsMenu)
$ToolsServer = GUICtrlCreateMenuItem("Retrieve server status", $ToolsMenu)
$ToolsFolder = GUICtrlCreateMenuItem("Change game folder", $ToolsMenu)
$ToolsNews = GUICtrlCreateMenuItem("News reader", $ToolsMenu)
$AccountList = GUICtrlCreateList("", 0, 0, 156, 214, 10486019)
GUICtrlSetLimit(-1, 200)
$ShardList = GUICtrlCreateCombo("", 0, 214, 78, 25, 2097475)
$ShardRegion = GUICtrlCreateCombo("", 78, 214, 78, 25, 2097475)
GUICtrlSetData(-1, "EU|US", "EU")
$Launch = GUICtrlCreateButton("Launch", 0, 235, 156, 24)
GUISetState(@SW_SHOW)
#endregion GUI

#region GUI Account
$AccountManager = GuiCreate("NFS World Account Manager", 250, 155, -1, -1, -1, 262528)
$EmailLabel = GUICtrlCreateLabel("E-Mail:", 10, 10, 150, 15)
$Email = GUICtrlCreateInput("", 10, 25, 230, 20)
$PasswordLabel = GUICtrlCreateLabel("Password:", 10, 50, 150, 15)
$Password = GUICtrlCreateInput("", 10, 65, 230, 20, 32)
$NameCheckbox = GUICtrlCreateCheckbox("Name:", 11, 97, 50, 15)
$Name = GUICtrlCreateInput("", 65, 96, 175, 17)
$AccountSave = GUICtrlCreateButton("Save", 10, 123, 230, 25)
#endregion

#region Loader
Server_Shards()
Game_AccountList()
News_Clean()
News_Get()
News_Sort()
#endregion

While 1
	$Msg = GuiGetMsg(1)
	Select
		;Launcher
		Case $Msg[0] = -3 and $Msg[1] = $Launcher
			Exit

		Case $Msg[0] = $Launch
			If GUICtrlRead($AccountList) = False Then
				MsgBox(64,$AppName,"Select account first!")
			Else
				$AccountFile = StringReplace(StringToBinary(GUICtrlRead($AccountList)),"0x","")
				$AccountEmail = IniRead(@ProgramFilesDir&$FolderPath&$AccountFile,$AccountFile,"456D61696C","")
				$AccountPassword = IniRead(@ProgramFilesDir&$FolderPath&$AccountFile,$AccountFile,"50617373776F7264","")
				If $AccountPassword = False OR $AccountEmail = False Then
					MsgBox(16,$AppName,"Account file is corrupted. Delete it and create new one.")
				Else
					If StringRight(StringLeft(Password_Decrypt($AccountPassword,StringRight($AccountPassword,1)),StringLen($AccountPassword)-1),StringLen($DriveSerialCode))=$DriveSerialCode=False Then
						MsgBox(48,$AppName,"This Account was created on another PC.")
					Else
						For $i = 0 to UBound($ShardName)-1 Step +1
							If $ShardName[$i] = GuiCtrlRead($ShardList) Then
								$GameServer = "https://"&$ShardIP[$i]&"/Engine.svc"
							EndIf
						Next
						IniWrite(@ProgramFilesDir&$FolderPath&$AccountFile,$AccountFile,"536572766572",StringReplace(StringToBinary(GUICtrlRead($ShardList)),"0x",""))
						IniWrite(@ProgramFilesDir&$FolderPath&$AccountFile,$AccountFile,"4C6F636174696F6E",StringReplace(StringToBinary(GUICtrlRead($ShardRegion)),"0x",""))
						Game_Launch($GameExe,$GameServer,GUICtrlRead($ShardRegion),$AccountEmail,$AccountPassword)
					EndIf
				EndIf
			EndIf

		;FILE
		Case $Msg[0] = $FileAdd
			$Edit = False
			GUISetState(@SW_SHOW, $AccountManager)
			GUICtrlSetData($Email, "")
			GUICtrlSetData($Password, "")
			GuiCtrlSetState($NameCheckbox, 4)
			GuiCtrlSetState($Name, 128)
			GuiCtrlSetData($Name, "")
		Case $Msg[0] = $FileEdit
			If GUICtrlRead($AccountList) = False Then
				MsgBox(64,$AppName,"Select account first!")
			Else
				$Edit = True
				$AccountFile = StringReplace(StringToBinary(GUICtrlRead($AccountList)),"0x","")
				GUISetState(@SW_SHOW, $AccountManager)
				GUICtrlSetData($Email, BinaryToString("0x"&IniRead(@ProgramFilesDir&$FolderPath&$AccountFile,$AccountFile,"456D61696C","")))
				GUICtrlSetData($Password, "")
				GUICtrlSetState($NameCheckbox, 1)
				GuiCtrlSetState($Name, 64)
				GuiCtrlSetData($Name, GUICtrlRead($AccountList))
			EndIf
		Case $Msg[0] = $FileRemove
			If GUICtrlRead($AccountList) = False Then
				MsgBox(64,$AppName,"Select account first!")
			Else
				$MsgBox = MsgBox(36,$AppName,"Do you really want to remove "&GUICtrlRead($AccountList)&" from Account list?")
				If $MsgBox = 6 Then ;Yes
					Game_AccountRemove()
					Game_AccountList()
				EndIf
			EndIf

		;TOOLS
		Case $Msg[0] = $ToolsRefreshAccount
			Game_AccountList()
		Case $Msg[0] = $ToolsRefreshShards
			Server_Shards()
		Case $Msg[0] = $ToolsServer
			Server_Status()
		Case $Msg[0] = $ToolsFolder
			Game_Directory()
		Case $Msg[0] = $ToolsNews
			GUISetState(@SW_SHOW, $NewsReader)

		;Account Manager
		Case $Msg[0] = -3 and $Msg[1] = $AccountManager
			GUISetState(@SW_HIDE, $AccountManager)
		Case $Msg[0] = $Email
			If GuiCtrlRead($NameCheckbox) = 4 Then
				GuiCtrlSetData($Name,GuiCtrlRead($Email))
			EndIf
		Case $Msg[0] = $NameCheckbox
			If GuiCtrlRead($NameCheckbox) = 1 Then
				GuiCtrlSetData($Name,"")
				GUICtrlSetState($Name, 64)
			Else
				GuiCtrlSetData($Name,GuiCtrlRead($Email))
				GuiCtrlSetState($Name, 128)
			EndIf
		Case $Msg[0] = $AccountSave
			If GUICtrlRead($Email) = False OR GUICtrlRead($Password) = False OR GUICtrlRead($Name) = False Then
				MsgBox(64, $AppName, "Please fill out all required fields.")
			Else
				If $Edit = True Then
					;delete current one so you can replace with new one
					Game_AccountRemove()
				EndIf
				;install new one
				Game_AccountNew()
				;refresh user list
				Game_AccountList()
				;hide the accountmanager
				GUISetState(@SW_HIDE, $AccountManager)
			EndIf

		;News Reader
		Case $Msg[0] = -3 And $Msg[1] = $NewsReader
			GUISetState(@SW_HIDE, $NewsReader)
		Case $Msg[0] = $Refresh
			News_Clean()
			News_Get()
			News_Sort()
		Case $Msg[0] = $ReadMore
			$i = GuiCtrlRead($NewsList[0])-$NewsList[1]+1 ;IF first is selected it will be x-x=0 and +1 will give 1, and 1 is correct, x-x2=1 and +1 wil give 2
			If $i <= 0 Then
				MsgBox(32,$AppName, "Select article first!")
			ElseIf $i > UBound($NewsList)-1 Then
				MsgBox(16,$AppName, "Unidentified error.")
			Else
				ShellExecute($NewsLink[$i])
			EndIf
	EndSelect
WEnd

#region Game
Func Game_AccountNew()
	$BinaryEmail = StringReplace(StringToBinary(GUICtrlRead($Email)),"0x","")
	$BinaryName = StringReplace(StringToBinary(GUICtrlRead($Name)),"0x","")
	IniWrite(@ProgramFilesDir&$FolderPath&$BinaryName,$BinaryName,"456D61696C",$BinaryEmail)
	IniWrite(@ProgramFilesDir&$FolderPath&$BinaryName,$BinaryName,"50617373776F7264", Password_Encrypt(GUICtrlRead($Password)&$DriveSerialCode,$Random)&$Random)
	IniWrite(@ProgramFilesDir&$FolderPath&$BinaryName,$BinaryName,"536572766572",StringReplace(StringToBinary(GUICtrlRead($ShardList)),"0x",""))
	IniWrite(@ProgramFilesDir&$FolderPath&$BinaryName,$BinaryName,"4C6F636174696F6E",StringReplace(StringToBinary(GUICtrlRead($ShardRegion)),"0x",""))
EndFunc
Func Game_AccountRemove()
	FileDelete(@ProgramFilesDir&$FolderPath&StringReplace(StringToBinary(GUICtrlRead($AccountList)),"0x",""))
EndFunc
Func Game_AccountList()
	GUICtrlSetData($AccountList, "")
	$Accounts = _FileListToArray(@ProgramFilesDir & $FolderPath, "*", 1)
	For $i = 1 To UBound($Accounts) - 1 Step +1
		GUICtrlSetData($AccountList, BinaryToString("0x" & $Accounts[$i]))
	Next
EndFunc   ;==>Game_AccountList
Func Game_Directory($EditMode = True)
	$GameExe = FileOpenDialog("Select nfsw.exe", @ProgramFilesDir, "Game (nfsw.exe)", 1)
	If Not @error Then
		IniWrite(@ProgramFilesDir & $GameFilePath, $GameFile, $GameFile, StringReplace($GameExe, "\nfsw.exe", ""))
	ElseIf $EditMode = False Then ; If this is your first time selecting file
		MsgBox(48, $AppName, "You have to select nfsw.exe!")
		Exit
	EndIf
EndFunc   ;==>Game_Directory
Func Game_Error()
	If $ErrorHandler.description = "" Then
		MsgBox(16,$AppName,"Unknown error")
	Else
		MsgBox(16, $AppName,$ErrorHandler.description)
	EndIf
	Exit
EndFunc
;~ Game_Launch($GameExe,$GameServer,GUICtrlRead($ShardRegion),$AccountEmail,$AccountPassword)
Func Game_Launch($GameExe,$GameServer,$ShardRegion,$AccountEmail,$AccountPassword)
	If FileExists($GameExe&"\nfsw.exe")=False Then
		MsgBox(16,$AppName, "Path to the nfsw.exe is corrupted/not found. Please find and select nfsw.exe.")
		Game_Directory()
		$GameExe=IniRead(@ProgramFilesDir&$GameFilePath,$GameFile,$GameFile,"")
	EndIf
	$URL =$GameServer&"/User/AuthenticateUser2"
	$HTTP =ObjCreate("WinHttp.WinHttpRequest.5.1")
	$Shell =ObjCreate("WScript.Shell")
	$XML =ObjCreate("Microsoft.XMLDOM")
	$ErrorHandler =ObjEvent("AutoIt.Error","Game_Error")
	$HTTP.option(4) = "&H3300"
	$HTTP.option(17) = False
	$HTTP.settimeouts(0,10000,10000,10000)
	$HTTP.open("POST",$URL,False)
	$HTTP.setrequestheader("Content-Type", "text/xml;charset=utf-8")
	$HTTP.setrequestheader("User-Agent", "Mozilla/3.0 (compatible; My Browser/1.0)")
	$HTTP.setrequestheader("Connection", "close")
	$HTTP.send('<Credentials xmlns="http://schemas.datacontract.org/2004/07/Victory.DataLayer.Serialization"><Email>'&BinaryToString("0x"&$AccountEmail)&"</Email><Password>"&StringReplace(StringLeft(Password_Decrypt($AccountPassword,StringRight($AccountPassword,1)),StringLen($AccountPassword)-1),$DriveSerialCode,"")&"</Password><Region>"&$ShardRegion & "</Region></Credentials>")
	$HTTP.waitforresponse
	$ResponseText = $HTTP.responsetext
	$XML.async = False
	$XML.loadxml($ResponseText)
	For $temp In $xml.documentelement.childnodes
		If $temp.nodename="ErrorCode" Then $ErrorCode=$temp.text
		If $temp.nodename = "securityToken" Then
			$Security = $temp.text
		EndIf
		If $temp.nodename = "userId" Then
			$User = $temp.text
		EndIf
	Next
	Select
		Case $ErrorCode = "-520"
			MsgBox(48, $AppName, "Please check the availability of servers and try again.")
		Case $ErrorCode = "-710"
			MsgBox(48, $AppName, "Parameters are incorrect (Check E-mail and password)")
		Case $ErrorCode = "-746"
			MsgBox(48, $AppName, "You specified invalid E-mail")
		Case $ErrorCode = "-747"
			MsgBox(48, $AppName, "You specified invalid Password")
		Case $ErrorCode = "-750"
			MsgBox(16, $AppName, "This account has been permanently banned for violation of the Terms of Service!")
		Case $ErrorCode = "Farming Inc." = False
			MsgBox(48, $AppName, "Unknown error")
		Case Else
			$Shell.run('"'&$GameExe&'\nfsw.exe"'&$ShardRegion&" "&$GameServer&" "&$Security&" "&$User)
	EndSelect
	$ErrorCode = "Farming Inc."
	$ErrorHandler = 0
EndFunc
#endregion

#region Server
Func Server_Shards()
	GUICtrlSetData($ShardList, "")
	$Source = _INetGetSource("http://world.needforspeed.com/SpeedAPI/ws/game/nfsw/shard/list")
	If $Source <> "" Then ; If function didnt fail
		$ShardName = _StringBetween($Source, "<shardName>", "</shardName>")
		$ShardIp = _StringBetween($Source, "<urlName>", "</urlName>")
		GUICtrlSetData($ShardList, $ShardName[0]&"|"&$ShardName[1], "APEX")
	Else
		MsgBox(262144, $AppName, "Unable to contact servers./Servers are down.")
	EndIf
EndFunc
Func Server_Status()
	$Source = _INetGetSource("http://world.needforspeed.com/SpeedAPI/ws/game/nfsw/servers/status")
	If $Source <> "" Then ; If function didnt fail
		$StatusShard = _StringBetween($Source, "<shard>", "</shard>")
		$StatusInfo = _StringBetween($Source, "<localizedMessage>", "</localizedMessage>")
		MsgBox(262144, $AppName, $StatusShard[0] & @CRLF & $StatusInfo[0] & @CRLF & @CRLF & $StatusShard[1] & @CRLF & $StatusInfo[1])
	Else
		MsgBox(262144, $AppName, "Unable to contact servers./Servers are down.")
	EndIf
EndFunc   ;==>Server_Status
#endregion Launcher

#region Password
Func Password_Encrypt($Serial, $Key = 25)
	;$Password is hooked with serial key of C:/ drive
	$StringSerial = String($Serial)
	$StringLenght = StringLen($StringSerial)
	$Array = StringToASCIIArray($StringSerial)
	Dim $StringArray[StringLen($StringSerial)]
	For $i = 0 To $StringLenght-1 Step 1
		$Array[$i] = BitXOR($Array[$i], $Key)
	Next
	For $i = 0 To $StringLenght - 1 Step 1
		$StringArray[$i] = ChrW($Array[$i])
	Next
	Return _ArrayToString($StringArray,"")
EndFunc
Func Password_Decrypt($Serial, $Key = 25)
	;$Password is hooked with serial key of C:/ drive
	$StringSerial = String($Serial)
	$StringLenght = StringLen($StringSerial)
	$Array = StringToASCIIArray($StringSerial)
	Dim $StringArray[StringLen($StringSerial)]
	For $i = 0 To $StringLenght-1 Step 1
		$StringArray[$i] = BitXOR($Array[$i], $Key)
	Next
	For $i = 0 To $StringLenght-1 Step 1
		$StringArray[$i] = ChrW($StringArray[$i])
	Next
	Return  _ArrayToString($StringArray,"")
EndFunc
#endregion

#region News
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
		MsgBox(262144, $AppName, "Unable to contact servers./Servers are down.")
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

#region UDF
Func _FileListToArray($spath, $sfilter = "*", $iflag = 0)
	Local $hsearch, $sfile, $sfilelist, $sdelim = "|"
	$spath = StringRegExpReplace($spath, "[\\/]+\z", "") & "\"
	If Not FileExists($spath) Then Return SetError(1, 1, "")
	If StringRegExp($sfilter, "[\\/:><\|]|(?s)\A\s*\z") Then Return SetError(2, 2, "")
	If Not ($iflag = 0 Or $iflag = 1 Or $iflag = 2) Then Return SetError(3, 3, "")
	$hsearch = FileFindFirstFile($spath & $sfilter)
	If @error Then Return SetError(4, 4, "")
	While 1
		$sfile = FileFindNextFile($hsearch)
		If @error Then ExitLoop
		If ($iflag + @extended = 2) Then ContinueLoop
		$sfilelist &= $sdelim & $sfile
	WEnd
	FileClose($hsearch)
	If Not $sfilelist Then Return SetError(4, 4, "")
	Return StringSplit(StringTrimLeft($sfilelist, 1), "|")
EndFunc   ;==>_FileListToArray
Func _ArrayToString(Const ByRef $avarray, $sdelim = "|", $istart = 0, $iend = 0)
	If NOT IsArray($avarray) Then Return SetError(1, 0, "")
	If UBound($avarray, 0) <> 1 Then Return SetError(3, 0, "")
	Local $sresult, $iubound = UBound($avarray) - 1
	If $iend < 1 OR $iend > $iubound Then $iend = $iubound
	If $istart < 0 Then $istart = 0
	If $istart > $iend Then Return SetError(2, 0, "")
	For $i = $istart To $iend
		$sresult &= $avarray[$i] & $sdelim
	Next
	Return StringTrimRight($sresult, StringLen($sdelim))
EndFunc
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
