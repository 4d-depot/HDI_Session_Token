shared singleton Class constructor()
	
	
	
exposed onHTTPGet Function validateEmail($token : Text) : 4D:C1709.OutgoingMessage
	
	var $result:=4D:C1709.OutgoingMessage.new()
	var $restore : Boolean
	
	$result.setBody:=("Validation failed")
	
	
	If (Session:C1714.storage.status=Null:C1517)
		
		$restore:=Session:C1714.restore($token)
		
		If (($restore=True:C214) && (Session:C1714.storage.status.step="Waiting for validation email"))
			
			$user:=ds:C1482.Users.get(Session:C1714.storage.status.ID)
			
			$result.setBody("Welcome "+Session:C1714.storage.status.fullname+"<br>"\
				+"Your email "+Session:C1714.storage.status.email+" has been validated")
			
			$result.setHeader("Content-Type"; "text/html")
			
			Use (Session:C1714.storage.status)
				Session:C1714.storage.status.step:="Email validated"
			End use 
			
		Else 
			$result.setBody("Validation failed")
		End if 
	End if 
	
	return $result
	
	
Function validateQodlyEmail() : 4D:C1709.OutgoingMessage
	
	var $result:=4D:C1709.OutgoingMessage.new()
	var $restore : Boolean
	
	$result.setBody:=("Validation failed")
	
	
	If (Session:C1714.storage.status.step="Waiting for validation email")
		
		$user:=ds:C1482.Users.get(Session:C1714.storage.status.ID)
		$user.validateEmail()
		
		$result.setBody("Congratulations <br>"\
			+"Your email "+Session:C1714.storage.status.email+" has been validated")
		
		$result.setHeader("Content-Type"; "text/html")
		
		Use (Session:C1714.storage.status)
			Session:C1714.storage.status.step:="Email validated"
		End use 
		
	Else 
		$result.setBody("Validation failed")
	End if 
	
	return $result
	
	
exposed onHTTPGet Function getProducts($token : Text) : 4D:C1709.OutgoingMessage
	
	var $result:=4D:C1709.OutgoingMessage.new()
	var $restore : Boolean
	var $product : cs:C1710.ProductsEntity
	var $body:="Here are the products in your basket:<br><br>"
	
	
	$result.setBody:=("Getting basket failed")
	
	
	If (Session:C1714.storage.products=Null:C1517)
		
		$restore:=Session:C1714.restore($token)
		
		If (($restore=True:C214) && (Session:C1714.storage.products#Null:C1517))
			
			For each ($product; Session:C1714.storage.products)
				$body:=$body+" "+$product.name+"<br>"
			End for each 
			
			$result.setBody($body)
			$result.setHeader("Content-Type"; "text/html")
			
		Else 
			$result.setBody("Getting basket failed")
		End if 
	End if 
	
	return $result
	
	
exposed Function validatePayment($chosenProducts : cs:C1710.ProductsSelection) : Text
	
	var $result:="Payment failed"
	
	
	Use (Session:C1714.storage)
		Session:C1714.storage.info:=New shared object:C1526("paymentStatus"; "Calling payment app")
		Session:C1714.storage.chosenProducts:=$chosenProducts
	End use 
	
	$token:=Session:C1714.createOTP()
	
	$callBackURL:="http://127.0.0.1/callBack?state%253D"+$token
	
	$callExternalAppURL:="http://127.0.0.1:8044/4DACTION/callPaymentApp?redirect="+$callBackURL
	$requestObj:={method: HTTP GET method:K71:1}
	$request:=4D:C1709.HTTPRequest.new($callExternalAppURL; $requestObj).wait()
	
	
	If (Position:C15("Payment validated"; Session:C1714.storage.info.paymentStatus)#0)
		$result:=Session:C1714.storage.info.paymentStatus
	End if 
	
	return $result