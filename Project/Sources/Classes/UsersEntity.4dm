Class extends Entity

//exposed Function get fullname() : Text

//Case of 

//: (This.firstname=Null)
//If (This.lastname=Null)
//return ""
//Else 
//return This.lastname
//End if 

//: (This.lastname=Null)
//If (This.firstname=Null)
//return ""
//Else 
//return This.firstname
//End if 

//Else 
//return This.firstname+" "+This.lastname

//End case 


//Function validateEmail()

//var $theEmail : cs.EmailsEntity
//var $status : Object


//$theEmail:=This.emails.first()
//$theEmail.validated:=True
//$status:=$theEmail.save()