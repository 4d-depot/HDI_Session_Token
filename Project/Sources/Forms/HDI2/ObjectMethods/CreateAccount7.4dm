

If (btnTrace)
	TRACE:C157
End if 


If (Form:C1466.selectedEmail#Null:C1517)
	
	If (Position:C15("/validateEmail"; Form:C1466.selectedEmail.link)#0)
		
		SET TEXT TO PASTEBOARD:C523(Form:C1466.selectedEmail.link)
		
		ALERT:C41("The link "+Form:C1466.selectedEmail.link+" has been copied in the pasteboard")
	End if 
	
End if 