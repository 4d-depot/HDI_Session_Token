Class extends DataStoreImplementation



exposed Function authentify($credentials : Object; $createAccount : Boolean) : Text
	
	var $user : cs:C1710.UsersEntity
	var $result : Text
	
	
	Case of 
		: ($createAccount)
			$result:=ds:C1482.Users.createQodlyUser($credentials)
			If ($result#"OK")
				Web Form:C1735.setError($result)
				return "CreateAccount"
			Else 
				Session:C1714.setPrivileges("forDemo")
				Web Form:C1735.setMessage("Account created - Go back to 4D to check the emails")
				return "CreateAccount"
			End if 
			
		: ($credentials.getSessionId)
			return Session:C1714.id
			
		Else 
			$user:=ds:C1482.Users.query("email == :1 && validated = :2"; $credentials.email; True:C214).first()
			
			If ($user#Null:C1517)
				If (Verify password hash:C1534($credentials.password; $user.password))
					Session:C1714.clearPrivileges()
					Session:C1714.setPrivileges("forDemo")
					
					Use (Session:C1714.storage)
						Session:C1714.storage.user:=New shared object:C1526("ID"; $user.ID)
						Session:C1714.storage.chosenProducts:=Null:C1517
					End use 
					return "Products"
				Else 
					Web Form:C1735.setError("Wrong credentials. Be sure your have created an account and validated the email")
					return "Authentication"
				End if 
			Else 
				Web Form:C1735.setError("Wrong credentials. Be sure your have created an account and validated the email")
				return "Authentication"
			End if 
			
	End case 