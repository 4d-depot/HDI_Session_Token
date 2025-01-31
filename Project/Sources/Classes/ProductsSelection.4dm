Class extends EntitySelection


exposed Function saveInSession()
	
	var $token : Text
	var $user : cs:C1710.UsersEntity
	var $notDropped : cs:C1710.UsersSelection
	var $mail : cs:C1710.EmailsEntity
	var $status : Object
	
	Use (Session:C1714.storage)
		Session:C1714.storage.inventory:=This:C1470
		Session:C1714.storage.info:=New shared object:C1526("inventoryFilled"; True:C214)
	End use 
	
	$token:=Session:C1714.createOTP()
	
	//Get the authenticated user
	$user:=ds:C1482.Users.get(Session:C1714.storage.user.ID)
	
	$notDropped:=ds:C1482.Emails.all().drop()
	
	$mail:=ds:C1482.Emails.new()
	$mail.link:="127.0.0.1/retrieveInventory?$4DSID="+$token
	$mail.subject:="View inventory for "+$user.email
	$mail.user:=$user
	$status:=$mail.save()
	
	Web Form:C1735.setMessage("Time flies ... You forgot your inventory - But you received a reminder email - Go back to 4D to check the emails")
	