extends Node
class_name RevenueManager

signal revenue_generated(revenue: float)

const INITIAL_REVENUE_PER_SESSION: float = 0.02

var current_revenue_per_session: float = INITIAL_REVENUE_PER_SESSION

func generate_revenue(sessions: int) -> void:
	var revenue = sessions * current_revenue_per_session
	revenue_generated.emit(revenue)

