#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%

; Variables for tracking double press
LastCtrlPress := 0
DoublePressThreshold := 300  ; milliseconds
DoublePressPending := false

; Chrome-specific hotkey
#IfWinActive ahk_class Chrome_WidgetWin_1
~LCtrl::
    GoSub, CheckCtrlPress
return

; PotPlayer-specific hotkey
#IfWinActive ahk_class PotPlayer64
~LCtrl::
    GoSub, CheckCtrlPress
return

; Universal handling for Ctrl press
CheckCtrlPress:
    CurrentTime := A_TickCount
    
    if (DoublePressPending) {
        ; This is the second press
        TimeSinceLastPress := CurrentTime - LastCtrlPress
        
        if (TimeSinceLastPress < DoublePressThreshold) {
            ; Valid double press, send z
            Send, z
        }
        
        ; Reset tracking
        DoublePressPending := false
        LastCtrlPress := 0
    } else {
        ; First press, start tracking
        LastCtrlPress := CurrentTime
        DoublePressPending := true
        
        ; Set a timer to reset if second press doesn't come
        SetTimer, ResetDoublePress, %DoublePressThreshold%
    }
return

; Reset the double press tracking if timeout occurs
ResetDoublePress:
    SetTimer, ResetDoublePress, Off
    DoublePressPending := false
    LastCtrlPress := 0
return