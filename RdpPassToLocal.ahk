;@Ahk2Exe-SetMainIcon rhh.ico
;@Ahk2Exe-AddResource rhh_mic_muted.ico, 160
;@Ahk2Exe-Set FileVersion, 1.0.0.0
;@Ahk2Exe-Set ProductVersion, 1.0.0.0

#SingleInstance Force
#NoEnv
#KeyHistory 0
Menu, Tray, Tip, RDP Pass To Local
Menu, Tray, NoStandard
Menu, Tray, Add, Exit

global RdpWindowTitle := % (SubStr(A_Language, -1) = "07" ? " - Remotedesktop" : " - Remote Desktop") ; matches both classic RDP client and the app from the Microsoft store
SetTitleMatchMode, 2
DetectHiddenWindows, On
While true {
  WinWaitActive, %RdpWindowTitle%
  Suspend, On ; rebind all hotkeys, otherwise they won't work in RDP fullscreen mode
  Suspend, Off
  Sleep, 250
  SetNumLockState, On ; the remote desktop client disables num lock upon first connection for some reason
  WinWaitNotActive, %RdpWindowTitle%
}

#UseHook
Volume_Down::PassToLocalMachine()
Volume_Up::PassToLocalMachine()
Media_Next::PassToLocalMachine()
Media_Prev::PassToLocalMachine()
Media_Stop::PassToLocalMachine()
Media_Play_Pause::PassToLocalMachine()
F13::PassToLocalMachine()
!^Down:: send {RAlt down}{XButton2}{RAlt up} ; Ctrl + Alt + Down

PassToLocalMachine() {
  WinGetText, ActiveWindowTitle, A
  If Not InStr(ActiveWindowTitle, RdpWindowTitle) {
    Send {%A_ThisHotKey%}
    Return
  }
  WM_APPCOMMAND := 0x0319
  If (A_ThisHotKey = "Media_Play_Pause")
    PostMessage, WM_APPCOMMAND, 0, 14<<16,, ahk_class Shell_TrayWnd ; APPCOMMAND_MEDIA_PLAY_PAUSE
  Else If (A_ThisHotKey = "Media_Stop")
    PostMessage, WM_APPCOMMAND, 0, 13<<16,, ahk_class Shell_TrayWnd ; APPCOMMAND_MEDIA_STOP
  Else If (A_ThisHotKey = "Media_Prev")
    PostMessage, WM_APPCOMMAND, 0, 12<<16,, ahk_class Shell_TrayWnd ; APPCOMMAND_MEDIA_PREVIOUSTRACK
  Else If (A_ThisHotKey = "Media_Next")
    PostMessage, WM_APPCOMMAND, 0, 11<<16,, ahk_class Shell_TrayWnd ; APPCOMMAND_MEDIA_NEXTTRACK
  Else If (A_ThisHotKey = "Volume_Up")
    PostMessage, WM_APPCOMMAND, 0, 10<<16,, ahk_class Shell_TrayWnd ; APPCOMMAND_VOLUME_UP
  Else If (A_ThisHotKey = "Volume_Down")
    PostMessage, WM_APPCOMMAND, 0, 9<<16,, ahk_class Shell_TrayWnd ; APPCOMMAND_VOLUME_DOWN
  Else If (A_ThisHotKey = "Volume_Mute")
    PostMessage, WM_APPCOMMAND, 0, 8<<16,, ahk_class Shell_TrayWnd ; APPCOMMAND_VOLUME_MUTE
  Else If (A_ThisHotKey = "F13")
    PostMessage, WM_APPCOMMAND, 0, 7<<16,, ahk_class Shell_TrayWnd ; F13
}

Exit:
ExitApp
