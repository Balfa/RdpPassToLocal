rem install.cmd
rem installs the RdpPassToLocal AHK script so it starts every time I log in to windows.

rem To install directly from github using git bash:
rem curl -sL https://raw.githubusercontent.com/Balfa/RdpPassToLocal/main/install.cmd | cmd

git clone https://github.com/Balfa/RdpPassToLocal.git
cd RdpPassToLocal
set TARGET='%cd%\RdpPassToLocal.ahk'
set SHORTCUT='%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\RdpPassToLocal.lnk'
set PWS=powershell.exe -ExecutionPolicy Bypass -NoLogo -NonInteractive -NoProfile

%PWS% -Command "$ws = New-Object -ComObject WScript.Shell; $s = $ws.CreateShortcut(%SHORTCUT%); $S.TargetPath = %TARGET%; $S.Save()"
