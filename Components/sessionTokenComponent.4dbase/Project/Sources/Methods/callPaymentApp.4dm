//%attributes = {"publishedWeb":true}


var $requestObj; $callback : Object

ARRAY TEXT:C222($anames; 0)
ARRAY TEXT:C222($avalues; 0)
WEB GET VARIABLES:C683($anames; $avalues)

$index:=Find in array:C230($anames; "redirect")
$urlToCall:=$avalues{$index}

$requestObj:={method: HTTP POST method:K71:2; body: "Payment validated"}
$callback:=4D:C1709.HTTPRequest.new($urlToCall; $requestObj).wait()


