rem add-soundswitch-to-startup.cmd
rem adds soundswitch to the startup menu so it starts every time I log in to windows.
rem https://community.chocolatey.org/packages/soundswitch
rem This isn't strictly related to to RdpPassToLocal, but I use the two together, so this is as good a place as any to make this script readily available

rem To run this directly from github using git bash:
rem curl -sL https://raw.githubusercontent.com/Balfa/RdpPassToLocal/main/add-soundswitch-to-startup.cmd | cmd

cp "/c/ProgramData/Microsoft/Windows/Start Menu/Programs/SoundSwitch/SoundSwitch.lnk" "%APPDATA%/Microsoft/Windows/Start Menu/Programs/Startup/"
