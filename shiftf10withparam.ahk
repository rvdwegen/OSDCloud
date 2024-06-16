#Requires AutoHotkey v2.0

; Example command line input:
; MyCompiledScript.exe "url=https://u.vdwegen.app/postOOBE,oobeTitle=Microsoft-account,activatePostOOBE=Post OOBE Bootstrap"

; Parse the first command line argument assuming it's a structured key-value string
if (A_Args.Length > 0) {
    params := StrSplit(A_Args[1], ",")
    paramMap := Map()
    for param in params {
        kv := StrSplit(param, "=")
        paramMap[kv[1]] := kv[2]
    }

    ; Access the parameters by name
    url := paramMap["url"]
    oobeTitle := paramMap["oobeTitle"]
    activatePostOOBE := paramMap["activatePostOOBE"]
} else {
    MsgBox "Error: No parameters provided."
    ExitApp
}

WinWait oobeTitle
    WinActivate
    Send "+{F10}"

WinWait "Administrator: C:\Windows\system32\cmd.exe"
pid := WinGetPID()
ProcessClose pid

Run("powershell -NoExit -ExecutionPolicy Bypass -Command irm " url " | iex")

WinWait activatePostOOBE
    WinActivate

ExitApp