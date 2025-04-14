Class extends DataClass



exposed Function create($info : Object) : Text
	
	var $user : cs:C1710.UsersEntity
	var $status : Object
	var $token : Text
	var $notDropped : cs:C1710.EmailsSelection
	var $mail : cs:C1710.EmailsEntity
	
	var $validationMail : Text
	
	
	If (This:C1470.query("email = :1"; $info.email).length>=1)
		Web Form:C1735.setError("An account already exist for this email address")
	Else 
		$user:=This:C1470.new()
		$user.email:=$info.email
		$user.password:=Generate password hash:C1533($info.password)
		$status:=$user.save()
		
		Use (Session:C1714.storage)
			Session:C1714.storage.status:=New shared object:C1526("step"; "Waiting for validation email"; "email"; $user.email; "ID"; $user.ID)
		End use 
		
		$token:=Session:C1714.createOTP()
		
		//$notDropped:=ds.Emails.all().drop()
		
		//$mail:=ds.Emails.new()
		$validationMail:="127.0.0.1/validateEmail?$4DSID="+$token
		//$mail.subject:="Validate email for "+$info.email
		//$mail.user:=$user
		//$status:=$mail.save()
		return $validationMail
	End if 
	