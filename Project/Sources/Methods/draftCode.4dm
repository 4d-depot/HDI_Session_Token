//%attributes = {}


ds:C1482.Products.getProductData()


$remoteDatastore:=Open datastore:C1452({hostname: "127.0.0.1"}; "remoteDS")

$link:=$remoteDatastore.Products.all().validate()