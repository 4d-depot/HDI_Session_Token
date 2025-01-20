Class extends EntitySelection


exposed Function saveProducts()
	
	Use (Session:C1714.storage)
		Session:C1714.storage.info:=New shared object:C1526("basketFilled"; True:C214)
		Session:C1714.storage.chosenProducts:=This:C1470
	End use 
	
	$token:=Session:C1714.createOTP()
	
	//Get the authenticated user
	$user:=ds:C1482.Users.get(Session:C1714.storage.user.ID)
	
	$notDropped:=ds:C1482.Emails.all().drop()
	
	$mail:=ds:C1482.Emails.new()
	$mail.link:="127.0.0.1/retrieveProducts?$4DSID="+$token
	$mail.subject:="View saved products for "+$user.email
	$mail.user:=$user
	$status:=$mail.save()
	
	Web Form:C1735.setMessage("Time flies ... You forgot your products - But you received a reminder email - Go back to 4D to check the emails")
	