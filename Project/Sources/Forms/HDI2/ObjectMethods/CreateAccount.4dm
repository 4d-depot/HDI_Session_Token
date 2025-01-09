

var $requestObj : Object
var $request : Object


//$headers:=buildHeaders

$requestObj:={method: HTTP POST method:K71:2; body: New collection:C1472(Form:C1466.info; computeLifeSpan)}

//$requestObj:={method: HTTP POST method; body: New collection(Form.info; computeLifeSpan); headers: $headers}

$request:=4D:C1709.HTTPRequest.new(Form:C1466.createAccountURL; $requestObj).wait()


If ($request.response.status=402)
	ALERT:C41("No more 4D Client licence available")
Else 
	If (Value type:C1509($request.response.headers["set-cookie"])=Is collection:K8:32)
		$cookies:=$request.response.headers["set-cookie"]
		$cookie:=$cookies.find(Formula:C1597((Position:C15("4DSID_HDI_Session_Token"; $1.value)#0)))
	Else 
		$cookie:=$request.response.headers["set-cookie"]
	End if 
	
	
	$start:=Position:C15("4DSID_HDI_Session_Token"; $cookie)
	$end:=Position:C15(";"; $cookie; $start)
	
	
	If (Storage:C1525.session.cookie="")
		Use (Storage:C1525.session)
			Storage:C1525.session.cookie:=Substring:C12($cookie; $start; $end-$start)
		End use 
	End if 
	
End if 



Form:C1466.validateLink:=$request.response.body.result

Form:C1466.validateLinkWithoutParameter:="127.0.0.1/4DACTION/validateEmail"

