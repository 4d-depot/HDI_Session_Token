Class extends Entity



exposed Function addMeInSelection($selection : cs:C1710.ProductsSelection) : cs:C1710.ProductsSelection
	
	var $tempSelection : cs:C1710.ProductsSelection
	
	If (This:C1470.indexOf($selection)=-1)
		$tempSelection:=$selection.copy()
		$tempSelection.add(This:C1470)
		return $tempSelection
	Else 
		return $selection
	End if 
	
	