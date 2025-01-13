Class extends DataClass


exposed Function validateBasket($products : cs:C1710.ProductsSelection) : Text
	
	var $token : Text
	
	Use (Session:C1714.storage)
		Session:C1714.storage.products:=$products
	End use 
	
	
	$token:=Session:C1714.createOTP()
	
	return "127.0.0.1/rest/$singleton/Utilities/getProducts?$params="+"'"+"["+"\""+$token+"\""+"]'"
	