extends Node
class_name FinanceManager

signal funds_added(amount: float)
signal funds_removed(amount: float)


var current_funds: float

func add_initial_funds(funds_amount: float):
	add_funds(funds_amount)

func add_funds(amount:float):
	current_funds += amount
	funds_added.emit(amount)
	
	
func remove_funds(amount:float):
	current_funds -= amount
	funds_removed.emit(amount)
	
func can_purchase(amount: float) -> bool:
	return current_funds >= amount

