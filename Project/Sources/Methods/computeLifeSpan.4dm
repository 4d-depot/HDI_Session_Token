//%attributes = {}


#DECLARE() : Integer

Case of 
	: ((Form:C1466.life10#Null:C1517) && (Form:C1466.life10=1))
		return 10
		
	: ((Form:C1466.noLife#Null:C1517) && (Form:C1466.noLife=1))
		return 0
End case 