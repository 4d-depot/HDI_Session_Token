Class extends DataClass



exposed Function create($info : Object) : Text
	
	var $user : cs:C1710.UsersEntity
	var $status : Object
	var $token : Text
	
	
	$user:=This:C1470.new()
	$user.fromObject($info)
	$user.validated:=False:C215
	$user.password:=""
	
	$status:=$user.save()
	
	Use (Session:C1714.storage)
		Session:C1714.storage.status:=New shared object:C1526("step"; "Waiting for validation email"; "email"; $user.email; "fullname"; $user.fullname; "ID"; $user.ID)
	End use 
	
	$token:=Session:C1714.createOTP()
	
	return "127.0.0.1/4DACTION/validateEmail?$4DSID="+$token