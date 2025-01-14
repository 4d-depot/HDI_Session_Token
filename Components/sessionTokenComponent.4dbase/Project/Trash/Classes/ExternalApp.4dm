
shared singleton Class constructor()
	
	
exposed Function callMe($request : 4D:C1709.IncomingMessage)
	
	var $requestObj; $callback : Object
	
	//$request.urlQuery.redirect contains the callBack URL
	$requestObj:={method: HTTP POST method:K71:2; body: "External app has been called."}
	$callback:=4D:C1709.HTTPRequest.new($request.urlQuery.redirect; $requestObj).wait()
	
	
	
	