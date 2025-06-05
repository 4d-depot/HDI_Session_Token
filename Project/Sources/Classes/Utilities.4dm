shared singleton Class constructor()
	
	
	
exposed Function getSessionId() : Text
	return Session:C1714.id
	
	
exposed Function whereToNavigate() : Text
	
	var $result:="Authentication"
	
	If (Session:C1714.isGuest()=False:C215)
		$result:="Products"
	End if 
	
	return $result