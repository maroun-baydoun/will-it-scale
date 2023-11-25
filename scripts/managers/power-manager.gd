extends Node

signal hourly_power_consumption_increased(amount: int)
signal hourly_power_consumption_decreased(amount: int)
signal bill_calculated(amount: float)

var current_hourly_power_consumption :int = 0 #kWh
var power_price_per_kWh : float = 0.5


func increase_hourly_power_consumption(amount: int) -> void :
	current_hourly_power_consumption += amount
	hourly_power_consumption_increased.emit(amount)
	
	
func decrease_hourly_power_consumption(amount: int) -> void :
	current_hourly_power_consumption -= amount
	hourly_power_consumption_decreased.emit(amount)
	
	
func calculate_bill() -> void:
	var amount := current_hourly_power_consumption * power_price_per_kWh
	bill_calculated.emit(amount)
	
