@echo off
set HOSTNAME=%COMPUTERNAME%
set OUTPUTNAME=%HOSTNAME%.txt

@echo off
CLS
ECHO.
ECHO =============================
ECHO SimpleDFIR V.0.0.1
ECHO =============================
ECHO For any questions me@comor.bid
ECHO RUN_LOCATION = %~dp0
ECHO OUTPUTNAME = %OUTPUTNAME%

::::::::::::::::::::::::::::::::::::::::::::
:: Elevate.cmd - Version 4
:: Automatically check & get admin rights
:: See "https://stackoverflow.com/a/12264592/1016343" for description
::::::::::::::::::::::::::::::::::::::::::::
:init
 setlocal DisableDelayedExpansion
 set cmdInvoke=1
 set winSysFolder=System32
 set "batchPath=%~dpnx0"
 for %%k in (%0) do set batchName=%%~nk
 set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
 setlocal EnableDelayedExpansion

:checkPrivileges
  NET FILE 1>NUL 2>NUL
  if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

:getPrivileges
  if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)
  ECHO.
  ECHO **************************************
  ECHO Invoking UAC for Privilege Escalation
  ECHO **************************************

  ECHO Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"
  ECHO args = "ELEV " >> "%vbsGetPrivileges%"
  ECHO For Each strArg in WScript.Arguments >> "%vbsGetPrivileges%"
  ECHO args = args ^& strArg ^& " "  >> "%vbsGetPrivileges%"
  ECHO Next >> "%vbsGetPrivileges%"
  
  if '%cmdInvoke%'=='1' goto InvokeCmd 

  ECHO UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%vbsGetPrivileges%"
  goto ExecElevation

:InvokeCmd
  ECHO args = "/c """ + "!batchPath!" + """ " + args >> "%vbsGetPrivileges%"
  ECHO UAC.ShellExecute "%SystemRoot%\%winSysFolder%\cmd.exe", args, "", "runas", 1 >> "%vbsGetPrivileges%"

:ExecElevation
 "%SystemRoot%\%winSysFolder%\WScript.exe" "%vbsGetPrivileges%" %*
 exit /B

:gotPrivileges
  setlocal & cd /d %~dp0
  if '%1'=='ELEV' (del "%vbsGetPrivileges%" 1>nul 2>nul  &  shift /1)

::::::::::::::::::::::::::::::::::::::::::::
:: End of Elevation
::::::::::::::::::::::::::::::::::::::::::::

ECHO.
ECHO **************************************
ECHO Starting Scan
ECHO **************************************
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++ >>%~dp0%OUTPUTNAME%
echo COMPUTER DETAILS: >>%~dp0%OUTPUTNAME%
echo ----- >>%~dp0%OUTPUTNAME%
echo Version: >>%~dp0%OUTPUTNAME%
Ver >>%~dp0%OUTPUTNAME%
echo +++++++++++++ >>%~dp0%OUTPUTNAME%
echo System Info: >>%~dp0%OUTPUTNAME%
systeminfo >>%~dp0%OUTPUTNAME%
echo +++++++++++++ >>%~dp0%OUTPUTNAME%
echo Quser: >>%~dp0%OUTPUTNAME%
Quser >>%~dp0%OUTPUTNAME%
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++ >>%~dp0%OUTPUTNAME%
echo TIME: >>%~dp0%OUTPUTNAME%
echo ----- >>%~dp0%OUTPUTNAME%
echo Date: >>%~dp0%OUTPUTNAME%
Date /t time /t >>%~dp0%OUTPUTNAME%
echo +++++++++++++ >>%~dp0%OUTPUTNAME%
echo Time: >>%~dp0%OUTPUTNAME%
time /t >>%~dp0%OUTPUTNAME%
echo +++++++++++++ >>%~dp0%OUTPUTNAME%
echo TimeZone: >>%~dp0%OUTPUTNAME%
setlocal
for /f "tokens=*" %%f in ('tzutil /g') do (
  echo %%f
  ) >>%~dp0%OUTPUTNAME%
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++ >>%~dp0%OUTPUTNAME%
echo NETWORK: >>%~dp0%OUTPUTNAME%
echo ----- >>%~dp0%OUTPUTNAME%
echo HostName: >>%~dp0%OUTPUTNAME%
Hostname >>%~dp0%OUTPUTNAME%
echo +++++++++++++ >>%~dp0%OUTPUTNAME%
echo Whoami: >>%~dp0%OUTPUTNAME%
Whoami >>%~dp0%OUTPUTNAME%
echo +++++++++++++ >>%~dp0%OUTPUTNAME%
echo Ano: >>%~dp0%OUTPUTNAME%
Netstat -ano >>%~dp0%OUTPUTNAME%
echo +++++++++++++ >>%~dp0%OUTPUTNAME%
echo Netstat: >>%~dp0%OUTPUTNAME%
Netstat -anb >>%~dp0%OUTPUTNAME%
echo +++++++++++++ >>%~dp0%OUTPUTNAME%
echo dip: >>%~dp0%OUTPUTNAME%
Ipconfig /all >>%~dp0%OUTPUTNAME%
echo +++++++++++++ >>%~dp0%OUTPUTNAME%
echo displaydns: >>%~dp0%OUTPUTNAME%
Ipconfig /displaydns >>%~dp0%OUTPUTNAME%
echo +++++++++++++ >>%~dp0%OUTPUTNAME%
echo NetUser: >>%~dp0%OUTPUTNAME%
Net user >>%~dp0%OUTPUTNAME%
echo +++++++++++++ >>%~dp0%OUTPUTNAME%
echo Arp: >>%~dp0%OUTPUTNAME%
Arp -a >>%~dp0%OUTPUTNAME%
echo +++++++++++++ >>%~dp0%OUTPUTNAME%
echo RoutePrint: >>%~dp0%OUTPUTNAME%
route print >>%~dp0%OUTPUTNAME%
echo +++++++++++++ >>%~dp0%OUTPUTNAME%
echo Nbtstat: >>%~dp0%OUTPUTNAME%
Nbtstat -S  >>%~dp0%OUTPUTNAME%
echo +++++++++++++ >>%~dp0%OUTPUTNAME%
echo NetSession: >>%~dp0%OUTPUTNAME%
Net sessions  >>%~dp0%OUTPUTNAME%
echo +++++++++++++ >>%~dp0%OUTPUTNAME%
echo Net View 127.0.0.1: >>%~dp0%OUTPUTNAME%
net view \\127.0.0.1  >>%~dp0%OUTPUTNAME%
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++ >>%~dp0%OUTPUTNAME%
echo TASKS: >>%~dp0%OUTPUTNAME%
echo ----- >>%~dp0%OUTPUTNAME%
echo TaskList: >>%~dp0%OUTPUTNAME%
Tasklist >>%~dp0%OUTPUTNAME%
echo +++++++++++++ >>%~dp0%OUTPUTNAME%
echo Tasks: >>%~dp0%OUTPUTNAME%
Tasklist -v >>%~dp0%OUTPUTNAME%
echo +++++++++++++ >>%~dp0%OUTPUTNAME%
echo SchTasks: >>%~dp0%OUTPUTNAME%
schtasks >>%~dp0%OUTPUTNAME%
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++ >>%~dp0%OUTPUTNAME%
echo BITLOCKER: >>%~dp0%OUTPUTNAME%
echo ----- >>%~dp0%OUTPUTNAME%
echo Bitlocker status: >>%~dp0%OUTPUTNAME%
manage-bde -status >>%~dp0%OUTPUTNAME%
echo +++++++++++++ >>%~dp0%OUTPUTNAME%
echo Bitlocker protector: >>%~dp0%OUTPUTNAME%
manage-bde -protectors C: -get >>%~dp0%OUTPUTNAME%
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++ >>%~dp0%OUTPUTNAME%
echo OTHERS: >>%~dp0%OUTPUTNAME%
echo ----- >>%~dp0%OUTPUTNAME%
echo Set: >>%~dp0%OUTPUTNAME%
set >>%~dp0%OUTPUTNAME%
echo +++++++++++++ >>%~dp0%OUTPUTNAME%
echo Shadow copies: >>%~dp0%OUTPUTNAME%
vssadmin list shadows >>%~dp0%OUTPUTNAME%
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++ >>%~dp0%OUTPUTNAME%
echo This was made with SimpleDFIR V.0.0.1 >>%~dp0%OUTPUTNAME%
echo For any questions me@comor.bid >>%~dp0%OUTPUTNAME%