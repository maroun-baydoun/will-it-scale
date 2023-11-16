extends Node

signal hourly_power_consumption_increased(amount: int)
signal hourly_power_consumption_decreased(amount: int)

var current_hourly_power_consumption :int = 0


func increase_hourly_power_consumption(amount: int) -> void :
	current_hourly_power_consumption += amount
	hourly_power_consumption_increased.emit(amount)
	
	

func decrease_hourly_power_consumption(amount: int) -> void :
	current_hourly_power_consumption -= amount
	hourly_power_consumption_decreased.emit(amount)
