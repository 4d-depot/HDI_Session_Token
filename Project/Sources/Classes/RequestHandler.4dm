

shared singleton Class constructor()
	
Function callApp($request : 4D:C1709.IncomingMessage) : 4D:C1709.OutgoingMessage
	
	
	var $result:=4D:C1709.OutgoingMessage.new()
	
	
	Use (Session:C1714.storage)
		Session:C1714.storage.info:=New shared object:C1526("message1"; "Calling external app")
	End use 
	
	$token:=Session:C1714.createOTP()
	
	$callBackURL:="http://127.0.0.1/callBack?%25244DSID%253D"+$token
	
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
	
	$coll:=OB Entries:C1720($request.urlQuery)
	
	$text:=$request.getText()
	
	If ($text#Null:C1517)
		
		If (Session:C1714.storage.info#Null:C1517)
			Use (Session:C1714.storage.info)
				Session:C1714.storage.info.message2:=$text
				Session:C1714.storage.info.message3:="Callback done with "+$coll[0].key+" = "+$coll[0].value
			End use 
		End if 
		
	End if 