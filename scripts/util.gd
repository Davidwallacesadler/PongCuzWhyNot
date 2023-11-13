extends Node

func int_to_string(integer: int) -> String:
	var format_string = "%s"
	return format_string % integer

func abs_value(float_num: float) -> float:
	if (float_num < 0):
		return -float_num
	return float_num
	
