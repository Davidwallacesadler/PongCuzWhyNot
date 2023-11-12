extends Node2D

@export var player_1: Player
@export var player_2: Player

@export var player_1_goal: Area2D
@export var player_2_goal: Area2D

@export var ball_container: Node2D

@export var player_1_score_label: Label
@export var player_2_score_label: Label

var _ball_scene = preload("res://ball.tscn")
var _ball: RigidBody2D

var _player_1_score := 0
var _player_2_score := 0

func _ready():
	player_1_goal.body_entered.connect(_on_ball_entered_player_1_goal)
	player_2_goal.body_entered.connect(_on_ball_entered_player_2_goal)
	_create_new_ball()
	_serve_ball_to_player(Player.Type.TWO)
	

func _on_ball_entered_player_1_goal(_body: Node2D) -> void:
	_player_2_score += 1
	_update_player_2_score_label()
	_reset_ball_and_serve.call_deferred(Player.Type.ONE)
	

func _on_ball_entered_player_2_goal(_body: Node2D) -> void:
	_player_1_score += 1
	_update_player_1_score_label()
	_reset_ball_and_serve.call_deferred(Player.Type.TWO)
	

func _reset_ball_and_serve(player: Player.Type) -> void:
	_ball.queue_free()
	_create_new_ball()
	_serve_ball_to_player(player)
	

func _serve_ball_to_player(player: Player.Type) -> void:
#	var rng = RandomNumberGenerator.new()
#	var random_y = rng.randf_range(-3, 3)
	if player == Player.Type.ONE:
		_ball.apply_impulse(Vector2(-5, 1))
	else:
		_ball.apply_impulse(Vector2(5, 1))
	

func _create_new_ball() -> void:
	_ball = _ball_scene.instantiate()
	ball_container.add_child(_ball)
	player_1.ball = _ball
	player_2.ball = _ball

func _update_player_1_score_label() -> void:
	player_1_score_label.text = Util.int_to_string(_player_1_score)
	

func _update_player_2_score_label() -> void:
	player_2_score_label.text = Util.int_to_string(_player_2_score)
	