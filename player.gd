class_name Player extends CharacterBody2D

@export var player_type: Type
@export var player_controlled: bool = true

const SPEED = 300.0

var ball: RigidBody2D

func _physics_process(delta):
	var vertical_velocity = _get_paddle_velocity()
	if vertical_velocity:
		self.velocity.y = vertical_velocity
	else:
		self.velocity.y = move_toward(velocity.y, 0, SPEED)
	self.move_and_slide()
	

func _get_paddle_velocity() -> float:
	if (player_controlled):
		return _get_player_velocity()
	else:
		return _get_ai_velocity()
		

func _get_ai_velocity() -> float:
	var delta_x = ball.global_position.x - global_position.x
	var x_mag = Util.abs_value(delta_x)
	if x_mag > 500:
		return 0
	
	var delta_y = ball.global_position.y - global_position.y
	if delta_y < 0:
		return clampf(delta_y, -SPEED, 0)
	else:
		return clampf(delta_y, 0, SPEED)
	

func _get_player_velocity() -> float:
	if (player_type == Type.ONE):
		return Input.get_axis("ui_up", "ui_down") * SPEED
	else:
		return Input.get_axis("ui_right", "ui_left") * SPEED
		

enum Type {
	ONE, TWO
}
