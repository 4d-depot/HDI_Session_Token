shared singleton Class constructor()
	
	
	
exposed onHTTPGet Function validateEmail($token : Text) : 4D:C1709.OutgoingMessage
	
	var $result:=4D:C1709.OutgoingMessage.new()
	var $restore : Boolean
	
	$result.setBody:=("Test failed")
	
	
	If (Session:C1714.storage.status=Null:C1517)
		
		$restore:=Session:C1714.restore($token)
		
		If (($restore=True:C214) && (Session:C1714.storage.status.step="Waiting for validation email"))
			
			$user:=ds:C1482.Users.get(Session:C1714.storage.status.ID)
			$user.validateEmail()
			
			$result.setBody("Welcome "+Session:C1714.storage.status.fullname+"<br>"\
				+"Your email "+Session:C1714.storage.status.email+" has been validated")
			
			$result.setHeader("Content-Type"; "text/html")
			
			Use (Session:C1714.storage)
				Session:C1714.storage.status:=Null:C1517
			End use 
			
		Else 
			$result.setBody("Validation failed")
		End if 
	End if 
	
	return $result
	
	