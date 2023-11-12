class_name Player extends CharacterBody2D

@export var player_type: Type

const SPEED = 300.0

func _physics_process(delta):
	var direction = _get_direction_for_player()
	if direction:
		velocity.y = direction * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	move_and_slide()


func _get_direction_for_player() -> float:
	if (player_type == Type.ONE):
		return Input.get_axis("ui_up", "ui_down")
	else:
		return Input.get_axis("ui_right", "ui_left")

enum Type {
	ONE, TWO
}
