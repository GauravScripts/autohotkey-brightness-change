; Variables
Increments := 10 ; < lower for a more granular change, higher for larger jump in brightness 
CurrentBrightness := GetCurrentBrightNess()

; Hot Keys
; Ctrl + Up/Down
^Up::     ChangeBrightness( CurrentBrightness += Increments ) ; increase brightness
^Down::   ChangeBrightness( CurrentBrightness -= Increments ) ; decrease brightness

; Functions
ChangeBrightness( ByRef brightness := 50, timeout = 1 )
{
	if ( brightness >= 0 && brightness <= 100 )
	{
		For property in ComObjGet( "winmgmts:\\.\root\WMI" ).ExecQuery( "SELECT * FROM WmiMonitorBrightnessMethods" )
			property.WmiSetBrightness( timeout, brightness )	
	}
 	else if ( brightness > 100 )
 	{
 		brightness := 100
 	}
 	else if ( brightness < 0 )
 	{
 		brightness := 0
 	}
}

GetCurrentBrightNess()
{
	For property in ComObjGet( "winmgmts:\\.\root\WMI" ).ExecQuery( "SELECT * FROM WmiMonitorBrightness" )
		currentBrightness := property.CurrentBrightness	

	return currentBrightness
}