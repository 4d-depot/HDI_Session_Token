Class extends DataStoreImplementation



exposed Function authentify($credentials : Object) : Text
	
	var $user : cs:C1710.UsersEntity
	var $result : Text
	
	$user:=ds:C1482.Users.query("email == :1 && validated = :2"; $credentials.email; True:C214).first()
	
	If ($user#Null:C1517)
		If (Verify password hash:C1534($credentials.password; $user.password))
			Session:C1714.clearPrivileges()
			Session:C1714.setPrivileges("")
			
			Use (Session:C1714.storage)
				Session:C1714.storage.user:=New shared object:C1526("ID"; $user.ID)
			End use 
			$result:="Inventory"
		Else 
			Web Form:C1735.setError("Wrong credentials. Be sure your have created an account and validated the email")
			$result:="Authentication"
		End if 
	Else 
		Web Form:C1735.setError("Wrong credentials. Be sure your have created an account and validated the email")
		$result:="Authentication"
	End if 
	
	return $result
	
	
	
exposed Function createAccount($credentials : Object) : Text
	
	var $result : Text
	
	
	$result:=ds:C1482.Users.create($credentials)
	
	If ($result="OK")
		Session:C1714.setPrivileges("")
		Web Form:C1735.setMessage("Account created - Go back to 4D to check the emails")
	Else 
		Web Form:C1735.setError($result)
	End if 
	
	return "CreateAccount"