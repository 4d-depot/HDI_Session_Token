

//var $folder : 4D.Folder
var $options : Object
var $worker : 4D:C1709.SystemWorker

//$folder:=Folder(fk database folder)
$options:=New object:C1471
//$options.currentDirectory:=$folder
//$options.hideWindow:=False

If (Is macOS:C1572)
	
	$cmd:="/Applications/Google\\ Chrome.app/Contents/MacOS/Google\\ Chrome -incognito \""+Form:C1466.selectedEmail.link+"\""
	
	$worker:=4D:C1709.SystemWorker.new($cmd; $options)
	//$worker:=4D.SystemWorker.new("/Applications/Google\\ Chrome.app/Contents/MacOS/Google\\ Chrome -incognito \"www.google.com\""; $options)
End if 

If (Is Windows:C1573)
	$worker:=4D:C1709.SystemWorker.new("start chrome /incognito "+Form:C1466.selectedEmail.link; $options)
End if 