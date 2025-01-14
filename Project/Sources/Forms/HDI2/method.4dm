


var $schema : Picture


Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
		btnTrace:=False:C215
		
		InitInfo
		
		Form:C1466.info:={firstname: "Mary"; lastname: "Smith"; email: "mary.smith@acme.com"}
		
		Form:C1466.info2:={firstname: "John"; lastname: "Brown"; email: "john.brown@acme.com"}
		
		Form:C1466.noLife:=1
		
		Form:C1466.createAccountURL:="http://127.0.0.1/rest/Users/create"
		
		Form:C1466.validateLinkWithoutParameter:="Coming soon"
		
		Form:C1466.validateLink:="Coming soon"
		
		Form:C1466.createAccountURL2:="http://127.0.0.1/rest/Users/create2"
		
		Form:C1466.validateLink2:="Coming soon"
		
		Form:C1466.callExternalApp:="127.0.0.1/callExternalApp"
		
		Form:C1466.callExternalAppWithWrongCallBack:="127.0.0.1/callExternalAppWithWrongCallBack"
		
		Form:C1466.webAreaURL:=""
		
		READ PICTURE FILE:C678(File:C1566("/RESOURCES/CallBack.jpeg").platformPath; $schema)
		Form:C1466.schema:=$schema
		
		OBJECT SET ENABLED:C1123(*; "CreateAccount"; ((Form:C1466.life10=1) || (Form:C1466.noLife=1)))
		
		
		//Form.remoteDatastore:=Open datastore({hostname: "127.0.0.1"}; "remoteDS")
		//Form.products:=Form.remoteDatastore.Products.all()
		//Form.products:=ds.Products.all()
		//Form.validateBasket:="http://127.0.0.1/rest/Products/validateBasket"
		
		Form:C1466.getBasketLink:="Coming soon"
		
		OBJECT SET ENABLED:C1123(*; "Validate"; Form:C1466.selected#Null:C1517)
		
		
	: (Form event code:C388=On Close Box:K2:21)
		If (Is Windows:C1573 && Application info:C1599().SDIMode)
			QUIT 4D:C291
		Else 
			CANCEL:C270
		End if 
		
End case 

