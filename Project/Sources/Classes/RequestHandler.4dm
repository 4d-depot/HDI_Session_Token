
shared singleton Class constructor()
	
	
	
Function validateQodlyEmail() : 4D:C1709.OutgoingMessage
	
	var $result:=4D:C1709.OutgoingMessage.new()
	var $user : cs:C1710.UsersEntity
	var $status : Object
	
	
	$result.setBody("Validation failed")
	
	If (Session:C1714.storage.status.step="Waiting for validation email")
		
		$user:=ds:C1482.Users.get(Session:C1714.storage.status.ID)
		$user.validated:=True:C214
		$status:=$user.save()
		
		$result.setHeader("Location"; "http://127.0.0.1/$lib/renderer/?w=AccountCreated")
		$result.setStatus(302)
		
		Use (Session:C1714.storage.status)
			Session:C1714.storage.status.step:="Email validated"
		End use 
	End if 
	
	return $result
	
	
Function handleCallBack($request : 4D:C1709.IncomingMessage)
	
	$otp:=$request.urlQuery.state
	
	$restore:=Session:C1714.restore($otp)
	
	$text:=$request.getText()
	
	If ($text#Null:C1517)
		
		If (Session:C1714.storage.info#Null:C1517)
			Use (Session:C1714.storage.info)
				Session:C1714.storage.info.paymentStatus:=$text
				If (Session:C1714.storage.chosenProducts#Null:C1517)
					Session:C1714.storage.info.paymentStatus:=Session:C1714.storage.info.paymentStatus+" total price: "+String:C10(Session:C1714.storage.chosenProducts.sum("price"))
				End if 
			End use 
		End if 
	End if 
	
	
Function restoreChosenProducts($request : 4D:C1709.IncomingMessage)
	var $result:=4D:C1709.OutgoingMessage.new()
	
	$result.setHeader("Location"; "http://127.0.0.1/$lib/renderer/?w=ProductsReminder")
	$result.setStatus(302)
	
	
	return $result
	
	
	
	
	
	
	
	
	
	//Function callApp($request : 4D.IncomingMessage) : 4D.OutgoingMessage
	
	
	//var $result:=4D.OutgoingMessage.new()
	
	
	//Use (Session.storage)
	//Session.storage.info:=New shared object("message1"; "Calling external app")
	//End use 
	
	//$token:=Session.createOTP()
	
	//$callBackURL:="http://127.0.0.1/callBack?%2524state%253D"+$token
	
	//$callExternalAppURL:="http://127.0.0.1:8044/4DACTION/callExternalApp?redirect="+$callBackURL
	
	//$requestObj:={method: HTTP GET method}
	
	//Try
	//$request:=4D.HTTPRequest.new($callExternalAppURL; $requestObj).wait()
	//Catch
	//$i:=1
	//End try
	
	//If ((Session.storage.info.message2=Null) && (Session.storage.info.message3=Null))
	//$body:="<br>"+"<br>"+"No session restored"+"<br>"+"<br>"
	//Else 
	//$body:="<br>"+"<br>"+Session.storage.info.message1+"<br>"+"<br>"\
		+"<br>"+"<br>"+Session.storage.info.message2+"<br>"+"<br>"\
		+"<br>"+"<br>"+Session.storage.info.message3+"<br>"+"<br>"
	//End if 
	
	//$result.setBody($body)
	//$result.setHeader("Content-Type"; "text/html")
	
	//return $result
	
	
	//Function callAppWithWrongCallback($request : 4D.IncomingMessage) : 4D.OutgoingMessage
	
	
	//var $result:=4D.OutgoingMessage.new()
	
	
	//Use (Session.storage)
	//Session.storage.info:=New shared object("message1"; "Calling external app")
	//End use 
	
	//$token:=Session.createOTP()
	
	//$callBackURL:="http://127.0.0.1/callBack"
	
	//$callExternalAppURL:="http://127.0.0.1:8044/4DACTION/callExternalApp?redirect="+$callBackURL
	
	//$requestObj:={method: HTTP GET method}
	//$request:=4D.HTTPRequest.new($callExternalAppURL; $requestObj).wait()
	
	
	//If ((Session.storage.info.message2=Null) && (Session.storage.info.message3=Null))
	//$body:="<br>"+"<br>"+"No session restored"+"<br>"+"<br>"
	//Else 
	//$body:="<br>"+"<br>"+Session.storage.info.message1+"<br>"+"<br>"\
		+"<br>"+"<br>"+Session.storage.info.message2+"<br>"+"<br>"\
		+"<br>"+"<br>"+Session.storage.info.message3+"<br>"+"<br>"
	//End if 
	
	
	//$result.setBody($body)
	//$result.setHeader("Content-Type"; "text/html")
	
	//return $result
	
	