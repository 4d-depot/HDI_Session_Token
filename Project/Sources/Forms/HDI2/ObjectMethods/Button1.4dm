

var $requestObj : Object
var $request : Object


//$headers:={}
//$headers:=buildHeaders

$requestObj:={method: HTTP POST method:K71:2; body: [{firstname: "Mary"; lastname: "Smith"; email: "mary.smith@acme.com"}]}
//$requestObj:={method: HTTP POST method; body: [{firstname: "Mary"; lastname: "Smith"; email: "mary.smith@acme.com"}]; headers: $headers}

$request:=4D:C1709.HTTPRequest.new(Form:C1466.createAccountURL2; $requestObj).wait()


If ($request.response.status=402)
	ALERT:C41("No more 4D Client licence available")
End if 

//If (Value type($request.response.headers["set-cookie"])=Is collection)
//$cookies:=$request.response.headers["set-cookie"]
//$cookie:=$cookies.find(Formula((Position("4DSID_HDI_Session_Token"; $1.value)#0)))
//Else 
//$cookie:=$request.response.headers["set-cookie"]
//End if 


//$start:=Position("4DSID_HDI_Session_Token"; $cookie)
//$end:=Position(";"; $cookie)


//If (Storage.session.cookie="")
//Use (Storage.session)
//Storage.session.cookie:=Substring($cookie; $start; $end-$start)
//End use 
//End if 


Form:C1466.validateLink2:=$request.response.body.result