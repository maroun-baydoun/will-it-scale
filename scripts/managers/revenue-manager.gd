extends Node
class_name RevenueManager

signal revenue_generated(revenue: float)

const INITIAL_REVENUE_PER_SESSION: float = 0.04

var current_revenue_per_session: float = INITIAL_REVENUE_PER_SESSION

func generate_revenue(sessions: int, current_load_ratio: float) -> void:
	var current_load_bonus = 0.0 if current_load_ratio == 0.0 else min(0.01 / current_load_ratio, INITIAL_REVENUE_PER_SESSION )
	var revenue = sessions * (current_revenue_per_session + current_load_bonus)
	revenue_generated.emit(revenue)

