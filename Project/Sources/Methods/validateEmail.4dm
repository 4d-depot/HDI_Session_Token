//%attributes = {"publishedWeb":true}



If (Session:C1714.storage.status#Null:C1517)
	
	If (Session:C1714.storage.status.step="Waiting for validation email")
		
		$user:=ds:C1482.Users.get(Session:C1714.storage.status.ID)
		$user.validateEmail()
		
		WEB SEND TEXT:C677("Welcome "+Session:C1714.storage.status.fullname+"<br>"\
			+"Your email "+Session:C1714.storage.status.email+" has been validated")
		
	End if 
	
End if 