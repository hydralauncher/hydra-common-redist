Dim WinScriptHost
Set WinScriptHost = CreateObject("WScript.Shell")
scriptDir = Left(WScript.ScriptFullName, InStrRev(WScript.ScriptFullName, "\") - 1)
WinScriptHost.Run Chr(34) & scriptDir + "\install.bat" & Chr(34), 0
Set WinScriptHost = Nothing
