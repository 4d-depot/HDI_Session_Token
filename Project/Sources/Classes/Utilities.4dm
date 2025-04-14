shared singleton Class constructor()
	
	
	
	
exposed Function registerInventory($inventory : cs:C1710.ProductsSelection) : Text
	
	var $result; $token : Text
	var $callBackURL; $callExternalAppURL : Text
	var $requestObj : Object
	var $request : 4D:C1709.HTTPRequest
	
	Use (Session:C1714.storage)
		Session:C1714.storage.inventory:=$inventory
	End use 
	
	$token:=Session:C1714.createOTP()
	
	$callBackURL:="http://127.0.0.1/callBack?state="+$token
	
	return $callBackURL
	
	
exposed Function getInventory() : cs:C1710.ProductsSelection
	
	If (Session:C1714.storage.inventory#Null:C1517)
		return Session:C1714.storage.inventory
	Else 
		return ds:C1482.Products.newSelection()
	End if 
	
	
exposed Function getSessionId() : Text
	return Session:C1714.id
	
	
exposed Function copyContent($link : Text)
	
	SET TEXT TO PASTEBOARD:C523($link)
	
	Web Form:C1735.setMessage("Link copied in the pasteboard")