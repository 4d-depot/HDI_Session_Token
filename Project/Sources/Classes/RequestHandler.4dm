
shared singleton Class constructor()
	
	
Function callApp($request : 4D:C1709.IncomingMessage) : 4D:C1709.OutgoingMessage
	
	
	var $result:=4D:C1709.OutgoingMessage.new()
	
	
	Use (Session:C1714.storage)
		Session:C1714.storage.info:=New shared object:C1526("message1"; "Calling external app")
	End use 
	
	$token:=Session:C1714.createOTP()
	
	$callBackURL:="http://127.0.0.1/callBack?%2524state%253D"+$token
	
	$callExternalAppURL:="http://127.0.0.1:8044/4DACTION/callExternalApp?redirect="+$callBackURL
	
	$requestObj:={method: HTTP GET method:K71:1}
	
	Try
		$request:=4D:C1709.HTTPRequest.new($callExternalAppURL; $requestObj).wait()
	Catch
		$i:=1
	End try
	
	If ((Session:C1714.storage.info.message2=Null:C1517) && (Session:C1714.storage.info.message3=Null:C1517))
		$body:="<br>"+"<br>"+"No session restored"+"<br>"+"<br>"
	Else 
		$body:="<br>"+"<br>"+Session:C1714.storage.info.message1+"<br>"+"<br>"\
			+"<br>"+"<br>"+Session:C1714.storage.info.message2+"<br>"+"<br>"\
			+"<br>"+"<br>"+Session:C1714.storage.info.message3+"<br>"+"<br>"
	End if 
	
	$result.setBody($body)
	$result.setHeader("Content-Type"; "text/html")
	
	return $result
	
	
Function callAppWithWrongCallback($request : 4D:C1709.IncomingMessage) : 4D:C1709.OutgoingMessage
	
	
	var $result:=4D:C1709.OutgoingMessage.new()
	
	
	Use (Session:C1714.storage)
		Session:C1714.storage.info:=New shared object:C1526("message1"; "Calling external app")
	End use 
	
	$token:=Session:C1714.createOTP()
	
	$callBackURL:="http://127.0.0.1/callBack"
	
	$callExternalAppURL:="http://127.0.0.1:8044/4DACTION/callExternalApp?redirect="+$callBackURL
	
	$requestObj:={method: HTTP GET method:K71:1}
	$request:=4D:C1709.HTTPRequest.new($callExternalAppURL; $requestObj).wait()
	
	
	If ((Session:C1714.storage.info.message2=Null:C1517) && (Session:C1714.storage.info.message3=Null:C1517))
		$body:="<br>"+"<br>"+"No session restored"+"<br>"+"<br>"
	Else 
		$body:="<br>"+"<br>"+Session:C1714.storage.info.message1+"<br>"+"<br>"\
			+"<br>"+"<br>"+Session:C1714.storage.info.message2+"<br>"+"<br>"\
			+"<br>"+"<br>"+Session:C1714.storage.info.message3+"<br>"+"<br>"
	End if 
	
	
	$result.setBody($body)
	$result.setHeader("Content-Type"; "text/html")
	
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
	
	
	
	
	