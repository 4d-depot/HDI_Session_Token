Class extends DataStoreImplementation



exposed Function authentify($credentials : Object) : Text
	
	var $user : cs:C1710.UsersEntity
	var $result : Variant
	
	
	$result:="Wrong credentials"
	
	If ($credentials.createAccount)
		ds:C1482.Users.createQodlyUser($credentials)
		Session:C1714.setPrivileges("forDemo")
		Web Form:C1735.setMessage("Go back to 4D to check the mails")
	Else 
		$user:=ds:C1482.Users.query("email === :1"; $credentials.email).first()
		
		If ($user#Null:C1517)
			If (Verify password hash:C1534($credentials.password; $user.password))
				Session:C1714.clearPrivileges()
				Session:C1714.setPrivileges("forDemo")
				$result:="OK"
			End if 
		End if 
		
		If ($result="Wrong credentials")
			Web Form:C1735.setError($result)
		End if 
		
	End if 
	
	return $result