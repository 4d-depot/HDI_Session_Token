shared singleton Class constructor()
	
	
	
	
exposed Function registerInventory($inventory : cs:C1710.ProductsSelection) : Text
	
	var $result; $token : Text
	var $callBackURL; $callExternalAppURL : Text
	var $requestObj : Object
	var $request : 4D:C1709.HTTPRequest
	
	
	If ($inventory.length=0)
		$result:="Select products first"
	Else 
		Use (Session:C1714.storage)
			Session:C1714.storage.inventory:=$inventory
			Session:C1714.storage.info:=New shared object:C1526("inventoryStatus"; "Calling the registring app")
		End use 
		
		$token:=Session:C1714.createOTP()
		
		$callBackURL:="http://127.0.0.1/callBack?state="+$token
		
		$callExternalAppURL:="http://127.0.0.1:8044/4DACTION/callRegistringApp?redirect="+$callBackURL
		$requestObj:={method: HTTP GET method:K71:1}
		$request:=4D:C1709.HTTPRequest.new($callExternalAppURL; $requestObj).wait()
		
		If (Position:C15("Registring done"; Session:C1714.storage.info.inventoryStatus)#0)
			$result:=Session:C1714.storage.info.inventoryStatus
		Else 
			$result:="Registring failed"
		End if 
	End if 
	
	return $result
	
	
exposed Function getInventory() : cs:C1710.ProductsSelection
	
	If (Session:C1714.storage.inventory#Null:C1517)
		return Session:C1714.storage.inventory
	Else 
		return ds:C1482.Products.newSelection()
	End if 
	
	
exposed Function getSessionId() : Text
	return Session:C1714.id