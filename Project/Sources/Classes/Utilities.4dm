shared singleton Class constructor()
	
	
	
	//exposed onHTTPGet Function validateEmail($token : Text) : 4D.OutgoingMessage
	
	//var $result:=4D.OutgoingMessage.new()
	//var $restore : Boolean
	
	//$result.setBody:=("Validation failed")
	
	
	//If (Session.storage.status=Null)
	
	//$restore:=Session.restore($token)
	
	//If (($restore=True) && (Session.storage.status.step="Waiting for validation email"))
	
	//$user:=ds.Users.get(Session.storage.status.ID)
	
	//$result.setBody("Welcome "+Session.storage.status.fullname+"<br>"\
		+"Your email "+Session.storage.status.email+" has been validated")
	
	//$result.setHeader("Content-Type"; "text/html")
	
	//Use (Session.storage.status)
	//Session.storage.status.step:="Email validated"
	//End use 
	
	//Else 
	//$result.setBody("Validation failed")
	//End if 
	//End if 
	
	//return $result
	
	
	
	
	//exposed onHTTPGet Function getProducts($token : Text) : 4D.OutgoingMessage
	
	//var $result:=4D.OutgoingMessage.new()
	//var $restore : Boolean
	//var $product : cs.ProductsEntity
	//var $body:="Here are the products in your basket:<br><br>"
	
	
	//$result.setBody:=("Getting basket failed")
	
	
	//If (Session.storage.products=Null)
	
	//$restore:=Session.restore($token)
	
	//If (($restore=True) && (Session.storage.products#Null))
	
	//For each ($product; Session.storage.products)
	//$body:=$body+" "+$product.name+"<br>"
	//End for each 
	
	//$result.setBody($body)
	//$result.setHeader("Content-Type"; "text/html")
	
	//Else 
	//$result.setBody("Getting basket failed")
	//End if 
	//End if 
	
	//return $result
	
	
exposed Function validatePayment($chosenProducts : cs:C1710.ProductsSelection) : Text
	
	var $result:="Payment failed"
	
	If ($chosenProducts.length=0)
		$result:="Select products first"
	Else 
		Use (Session:C1714.storage)
			Session:C1714.storage.info:=New shared object:C1526("paymentStatus"; "Calling payment app")
			Session:C1714.storage.chosenProducts:=$chosenProducts
		End use 
		
		$token:=Session:C1714.createOTP()
		
		$callBackURL:="http://127.0.0.1/callBack?state="+$token
		//$callBackURL:="http://127.0.0.1/callBack?state%253D"+$token
		
		$callExternalAppURL:="http://127.0.0.1:8044/4DACTION/callPaymentApp?redirect="+$callBackURL
		$requestObj:={method: HTTP GET method:K71:1}
		$request:=4D:C1709.HTTPRequest.new($callExternalAppURL; $requestObj).wait()
		
		
		If (Position:C15("Payment validated"; Session:C1714.storage.info.paymentStatus)#0)
			$result:=Session:C1714.storage.info.paymentStatus
		End if 
		
	End if 
	return $result
	
	
exposed Function getSessionId() : Text
	return Session:C1714.id