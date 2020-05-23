@echo off

net session > nul 2>&1
if /i not %errorlevel%==0 (
  echo You must run this from an elevated prompt.
  goto:eof
)

call :setreg "HKCR\Directory\shell\runas"
call :setreg "HKCR\Directory\Background\shell\runas"

:setreg
  call :setrunas "%~1"
  call :setcommand "%~1\command"
  goto :eof

:setrunas
  call :setregval "%~1" /d "Open command window here (&Admin)"
  call :setregval "%~1" /v Extended
  call :setregval "%~1" /v NoWorkingDirectory
  goto :eof

:setcommand
  call :setregval "%~1" /d "cmd.exe /s /k pushd \"%%%%V\""
  goto :eof

:setregval
  reg add "%~1" "%~2" "%~3" /f > nul 2>&1
  goto :eof
