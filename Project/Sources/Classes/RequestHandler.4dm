
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
	
	
Function handleCallBack($request : 4D:C1709.IncomingMessage)
	
	var $otp; $text : Text
	var $restore : Boolean
	
	
	$otp:=$request.urlQuery.state
	
	$restore:=Session:C1714.restore($otp)
	
	$text:=$request.getText()
	
	If ($text#Null:C1517)
		
		If (Session:C1714.storage.info#Null:C1517)
			Use (Session:C1714.storage.info)
				Session:C1714.storage.info.inventoryStatus:=$text
				If (Session:C1714.storage.inventory#Null:C1517)
					Session:C1714.storage.info.inventoryStatus+=" total price: "+String:C10(Session:C1714.storage.inventory.sum("price"))
				End if 
			End use 
		End if 
	End if 
	
	
Function restoreInventory($request : 4D:C1709.IncomingMessage)
	var $result:=4D:C1709.OutgoingMessage.new()
	
	$result.setHeader("Location"; "http://127.0.0.1/$lib/renderer/?w=InventoryReminder")
	$result.setStatus(302)
	
	return $result
	
	
	
	