

If (btnTrace)
	TRACE:C157
End if 

If (Form:C1466.selectedEmail#Null:C1517)
	
	If (Position:C15("/retrieveInventory"; Form:C1466.selectedEmail.link)#0)
		WA OPEN URL:C1020(*; "WebArea"; Form:C1466.selectedEmail.link)
	End if 
	
End if 
