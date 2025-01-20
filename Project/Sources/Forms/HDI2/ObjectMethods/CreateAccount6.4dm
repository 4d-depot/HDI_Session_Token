

If (btnTrace)
	TRACE:C157
End if 

If (Form:C1466.selectedEmail#Null:C1517)
	
	If (Position:C15("View saved products"; Form:C1466.selectedEmail.subject)#0)
		OBJECT SET VISIBLE:C603(*; "SaveProductsLabel"; True:C214)
		WA OPEN URL:C1020(*; "WebArea"; Form:C1466.selectedEmail.link)
	End if 
	
End if 
