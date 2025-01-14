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
	