#Requires AutoHotkey v2.0

WinWait "Microsoft-account"
    WinActivate
    Send "+{F10}"

WinWait "Administrator: C:\Windows\system32\cmd.exe"
pid := WinGetPID()
ProcessClose pid

Run("powershell -NoExit -ExecutionPolicy Bypass -Command irm https://u.vdwegen.app/postOOBE | iex")

WinWait "Post OOBE Bootstrap"
    WinActivate

ExitApp