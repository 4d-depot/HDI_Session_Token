
shared singleton Class constructor()
	
	
	
Function validateEmail() : 4D:C1709.OutgoingMessage
	
	var $result:=4D:C1709.OutgoingMessage.new()
	var $user : cs:C1710.UsersEntity
	var $status : Object
	
	
	If (Session:C1714.storage.status.step="Waiting for validation email")
		$user:=ds:C1482.Users.get(Session:C1714.storage.status.ID)
		$user.validated:=True:C214
		$status:=$user.save()
		
		Use (Session:C1714.storage.status)
			Session:C1714.storage.status.step:="Email validated"
		End use 
		
		$result.setHeader("Location"; "http://127.0.0.1/$lib/renderer/?w=AccountCreated")
		$result.setStatus(302)
		
	Else 
		$result.setBody("Validation failed")
	End if 
	
	return $result
	
	
Function handleProducts($request : 4D:C1709.IncomingMessage) : 4D:C1709.OutgoingMessage
	
	var $otp : Text
	var $restore : Boolean
	var $result:=4D:C1709.OutgoingMessage.new()
	
	$otp:=$request.urlQuery.state
	
	TRACE:C157
	
	$restore:=Session:C1714.restore($otp)
	
	$result.setHeader("Location"; "http://127.0.0.1/$lib/renderer/?w=RetrievedProducts")
	$result.setStatus(302)
	
	return $result
	
	
	
	
	