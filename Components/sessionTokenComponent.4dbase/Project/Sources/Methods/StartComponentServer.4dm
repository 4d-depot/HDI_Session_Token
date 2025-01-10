//%attributes = {"shared":true}


#DECLARE() : Object


var $myComponentWebServer; $result; $options : Object

$myComponentWebServer:=WEB Server:C1674(Web server database:K73:30)

$options:=New object:C1471("HTTPPort"; 8044)

$myComponentWebServer.stop()

$result:=$myComponentWebServer.start($options)

return $result