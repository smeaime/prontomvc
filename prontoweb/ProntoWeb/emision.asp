<%
'on error resume next
dim app
ExecuteShellProgram "D:\Proyectos\Pronto Web\Emision\bin\Debug\Emision.exe"
if err.number <> 0 then
err.Raise
end if

Function ExecuteShellProgram(ByVal sFileName)
Dim poShell
Dim poProcess
Dim iStatus
Set poShell = CreateObject("WScript.Shell")
Set poProcess = poShell.Exec(sFileName)
'Check to see if we started the process without error
if ((poProcess.ProcessID=0) and (poProcess.Status=1)) then
Err.Raise vbObjectError,,"Failed executing process"
end if
'Now loop until the process has terminated, and pull out
'any console output
Do
'Get current state of the process
iStatus = poProcess.Status
'Forward console output from launched process
'to ours
'WScript.StdOut.Write poProcess.StdOut.ReadAll()
'WScript.StdErr.Write poProcess.StdErr.ReadAll()
'Did the process terminate?
if (iStatus <> 0) then
Exit Do
end if
Loop
'Return the exit code
ExecuteShellProgram = poProcess.ExitCode
End Function
 %>