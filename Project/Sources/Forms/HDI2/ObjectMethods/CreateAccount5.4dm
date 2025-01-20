

If (btnTrace)
	TRACE:C157
End if 


//Form.mails:=ds.Emails.query("validated = :1 or subject = :2"; False; "Retrieve products@").orderBy("ID")

Form:C1466.mails:=ds:C1482.Emails.all()

LISTBOX SELECT ROW:C912(*; "LBEmails"; 1)