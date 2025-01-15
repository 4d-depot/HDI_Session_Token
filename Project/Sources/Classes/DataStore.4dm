Class extends DataStoreImplementation



exposed Function authentify($credentials : Object; $createAccount : Boolean) : Text
	
	var $user : cs:C1710.UsersEntity
	var $result : Text
	//var $formula : Object
	
	//$result:="Wrong credentials. Be sure your have created an account"
	
	If ($createAccount)
		$result:=ds:C1482.Users.createQodlyUser($credentials)
		If ($result#"OK")
			Web Form:C1735.setError($result)
		Else 
			Session:C1714.setPrivileges("forDemo")
			Web Form:C1735.setMessage("Account created - Go back to 4D to check the mails")
		End if 
	Else 
		//$formula:=(This.emails.first().validated=True)
		//$user:=ds.Users.query("email === :1 and :2"; $credentials.email; $formula).first()
		$user:=ds:C1482.Users.query("email === :1"; $credentials.email).first()
		
		If (($user#Null:C1517) && ($user.emails.first().validated))
			If (Verify password hash:C1534($credentials.password; $user.password))
				Session:C1714.clearPrivileges()
				Session:C1714.setPrivileges("forDemo")
				return "Products"
			Else 
				Web Form:C1735.setError("Wrong credentials. Be sure your have created an account and validated the email")
				return "Authentication"
			End if 
		Else 
			Web Form:C1735.setError("Wrong credentials. Be sure your have created an account and validated the email")
			return "Authentication"
		End if 
		
	End if 
	
	//return $result