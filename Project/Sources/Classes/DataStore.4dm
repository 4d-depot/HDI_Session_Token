Class extends DataStoreImplementation



exposed Function authentify($credentials : Variant; $what : Text) : Text
	
	var $user : cs:C1710.UsersEntity
	var $result : Text
	
	Case of 
			
		: ($what="Authentify")
			$user:=ds:C1482.Users.query("email == :1 && validated = :2"; $credentials.email; True:C214).first()
			
			If ($user#Null:C1517)
				If (Verify password hash:C1534($credentials.password; $user.password))
					
					Use (Session:C1714.storage)
						Session:C1714.storage.user:=New shared object:C1526("ID"; $user.ID)
					End use 
					
					Session:C1714.setPrivileges("")
					
					$result:="Products"
				Else 
					Web Form:C1735.setError("Wrong credentials. Be sure you have created an account and validated the email")
					$result:="Authentication"
				End if 
			Else 
				Web Form:C1735.setError("Wrong credentials. Be sure you have created an account and validated the email")
				$result:="Authentication"
			End if 
			
		: ($what="getSessionId")
			$result:=cs:C1710.Utilities.me.getSessionId()
			
		: ($what="CreateAccount")
			$result:=ds:C1482.Users.create($credentials)
			
	End case 
	
	return $result
	
	
	
	