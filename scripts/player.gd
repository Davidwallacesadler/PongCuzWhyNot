class_name Player extends CharacterBody2D

@export var player_number: Number
@export var player_controlled: bool = true

const SPEED = 300.0

var ball: RigidBody2D

func _physics_process(delta):
	var vertical_direction = _get_paddle_direction()
	if vertical_direction:
		self.velocity.y = vertical_direction * SPEED
	else:
		self.velocity.y = move_toward(velocity.y, 0, SPEED)
	self.move_and_slide()
	

func _get_paddle_direction() -> float:
	if (player_controlled):
		return _get_player_direction()
	else:
		return _get_ai_direction()
		

func _get_ai_direction() -> float:
	var delta_x = ball.global_position.x - global_position.x
	var delta_y = ball.global_position.y - global_position.y
	
	# Don't move the paddle if the ball is "too far" away:
	var x_distance = Util.abs_value(delta_x)
	var x_view_distance: float = 250
	if x_distance > x_view_distance:
		return 0
	
	# Don't move the paddle when delta_y is "small":
	var movement_threshold: float = 50
	if Util.abs_value(delta_y) < movement_threshold:
		return 0
	
	# Move the paddle based on direction to ball:
	if delta_y < 0:
		return -1
	else:
		return 1
	

func _get_player_direction() -> float:
	if (player_number == Number.ONE):
		return Input.get_axis("ui_up", "ui_down")
	else:
		return Input.get_axis("ui_right", "ui_left")
		

enum Number {
	ONE, TWO
}
