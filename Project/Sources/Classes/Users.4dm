Class extends DataClass



exposed Function create($info : Object; $lifespan : Integer) : Text
	
	var $user : cs:C1710.UsersEntity
	var $status : Object
	var $token : Text
	
	
	$user:=This:C1470.new()
	$user.fromObject($info)
	$user.password:=""
	
	$status:=$user.save()
	
	Use (Session:C1714.storage)
		Session:C1714.storage.status:=New shared object:C1526("step"; "Waiting for validation email"; "email"; $user.email; "fullname"; $user.fullname; "ID"; $user.ID)
	End use 
	
	If ($lifespan#0)
		$token:=Session:C1714.createOTP($lifespan)
	Else 
		$token:=Session:C1714.createOTP()
	End if 
	
	return "127.0.0.1/4DACTION/validateEmail?$4DSID="+$token
	
	
	
Function createQodlyUser($info : Object) : Text
	
	var $user : cs:C1710.UsersEntity
	var $status : Object
	var $token : Text
	var $mail : cs:C1710.EmailsEntity
	var $notDropped : cs:C1710.EmailsSelection
	
	If (This:C1470.query("email = :1"; $info.email).length>=1)
		return "An account already exist"
	Else 
		$user:=This:C1470.new()
		$user.fromObject($info)
		$user.password:=Generate password hash:C1533($info.password)
		$status:=$user.save()
		
		Use (Session:C1714.storage)
			Session:C1714.storage.status:=New shared object:C1526("step"; "Waiting for validation email"; "email"; $user.email; "ID"; $user.ID)
		End use 
		
		$token:=Session:C1714.createOTP()
		
		$notDropped:=$user.emails.drop()
		
		$mail:=ds:C1482.Emails.new()
		$mail.link:="127.0.0.1/validateEmail?$4DSID="+$token
		$mail.validated:=False:C215
		$mail.user:=$user
		$status:=$mail.save()
		return "OK"
	End if 
	
	
exposed Function createForBlogpost($info : Object) : Text
	
	var $user : cs:C1710.UsersEntity
	var $status : Object
	var $token : Text
	
	
	$user:=This:C1470.new()
	$user.fromObject($info)
	$user.password:=""
	
	$status:=$user.save()
	
	Use (Session:C1714.storage)
		Session:C1714.storage.status:=New shared object:C1526("step"; "Waiting for validation email"; "email"; $user.email; "fullname"; $user.fullname; "ID"; $user.ID)
	End use 
	
	
	$token:=Session:C1714.createOTP()
	
	return "127.0.0.1/rest/$singleton/Utilities/validateEmailForBlogpost?$4DSID="+$token
	
	
exposed Function create2($info : Object) : Text
	
	var $user : cs:C1710.UsersEntity
	var $status : Object
	var $token : Text
	
	
	$user:=This:C1470.new()
	$user.fromObject($info)
	$user.password:=""
	
	$status:=$user.save()
	
	Use (Session:C1714.storage)
		Session:C1714.storage.status:=New shared object:C1526("step"; "Waiting for validation email"; "email"; $user.email; "fullname"; $user.fullname; "ID"; $user.ID)
	End use 
	
	$token:=Session:C1714.createOTP()
	
	return "127.0.0.1/rest/$singleton/Utilities/validateEmail?$params="+"'"+"["+"\""+$token+"\""+"]'"