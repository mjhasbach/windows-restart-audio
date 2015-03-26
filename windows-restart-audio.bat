:checkPrivileges
NET FILE 1>NUL 2>NUL
if "%errorlevel%" == "0" (goto gotPrivileges) else (goto getPrivileges)

:getPrivileges
if "%1" == "ELEV" (shift & goto gotPrivileges)

setlocal DisableDelayedExpansion
set "batchPath=%~0"
setlocal EnableDelayedExpansion
ECHO Set UAC = CreateObject^("Shell.Application"^) > "%temp%\OEgetPrivileges.vbs"
ECHO UAC.ShellExecute "!batchPath!", "ELEV", "", "runas", 1 >> "%temp%\OEgetPrivileges.vbs"
"%temp%\OEgetPrivileges.vbs"
exit /B

:gotPrivileges
setlocal & pushd .

net stop audiosrv
net stop AudioEndpointBuilder
net start audiosrv
net start AudioEndpointBuilder