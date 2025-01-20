


var $schema : Picture


Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
		btnTrace:=False:C215
		
		InitInfo
		
		//Form.info:={firstname: "Mary"; lastname: "Smith"; email: "mary.smith@acme.com"}
		
		//Form.info2:={firstname: "John"; lastname: "Brown"; email: "john.brown@acme.com"}
		
		//Form.noLife:=1
		
		//Form.createAccountURL:="http://127.0.0.1/rest/Users/create"
		
		//Form.validateLinkWithoutParameter:="Coming soon"
		
		//Form.validateLink:="Coming soon"
		
		//Form.createAccountURL2:="http://127.0.0.1/rest/Users/create2"
		
		//Form.validateLink2:="Coming soon"
		
		//Form.callExternalApp:="127.0.0.1/callExternalApp"
		
		//Form.callExternalAppWithWrongCallBack:="127.0.0.1/callExternalAppWithWrongCallBack"
		
		//Form.webAreaURL:=""
		
		//READ PICTURE FILE(File("/RESOURCES/CallBack.jpeg").platformPath; $schema)
		//Form.schema:=$schema
		
		//OBJECT SET ENABLED(*; "CreateAccount"; ((Form.life10=1) || (Form.noLife=1)))
		
		
		//Form.remoteDatastore:=Open datastore({hostname: "127.0.0.1"}; "remoteDS")
		//Form.products:=Form.remoteDatastore.Products.all()
		//Form.products:=ds.Products.all()
		//Form.validateBasket:="http://127.0.0.1/rest/Products/validateBasket"
		
		//Form.getBasketLink:="Coming soon"
		
		//OBJECT SET ENABLED(*; "Validate"; Form.selected#Null)
		
		
	: (Form event code:C388=On Close Box:K2:21)
		If (Is Windows:C1573 && Application info:C1599().SDIMode)
			QUIT 4D:C291
		Else 
			CANCEL:C270
		End if 
		
End case 

