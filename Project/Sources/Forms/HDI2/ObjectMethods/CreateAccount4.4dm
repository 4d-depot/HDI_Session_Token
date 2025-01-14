

var $requestObj : Object
var $request : Object

If (btnTrace)
	TRACE:C157
End if 


$requestObj:={method: HTTP POST method:K71:2; body: [Form:C1466.info2]}
$request:=4D:C1709.HTTPRequest.new("http://127.0.0.1/rest/Users/createForBlogpost"; $requestObj).wait()


If ($request.response.status=402)
	ALERT:C41("No more 4D Client licence available - Please restart the HDI")
End if 


Form:C1466.validateLink2:=$request.response.body.result