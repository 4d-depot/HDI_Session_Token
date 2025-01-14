Class extends EntitySelection





exposed Function bookTheBasket() : Text
	
	return "Test"
	
	
exposed Function someInfos() : Text
	
	//return "Test"
	
	var $token : Text
	
	Use (Session:C1714.storage)
		Session:C1714.storage.products:=This:C1470
	End use 
	
	
	$token:=Session:C1714.createOTP()
	
	return "127.0.0.1/rest/$singleton/Utilities/getProducts?$params="+"'"+"["+"\""+$token+"\""+"]'"