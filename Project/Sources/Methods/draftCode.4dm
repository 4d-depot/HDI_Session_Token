//%attributes = {}



$emails:=ds:C1482.Emails.query("validated = :1 or subject = :2"; False:C215; "Retrieve products").orderBy("ID")