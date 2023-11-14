extends Node2D

@export var player_1: Player
@export var player_2: Player

@export var player_1_goal: Area2D
@export var player_2_goal: Area2D

@export var ball_container: Node2D

@export var player_1_score_label: Label
@export var player_2_score_label: Label

@export var audio_player: AudioStreamPlayer

var _ball_scene = preload("res://scenes/ball.tscn")
var _goal_audio = preload("res://assets/goal.wav")
var _paddle_collision_audio = preload("res://assets/paddle_collision.wav")
var _wall_collision_audio = preload("res://assets/wall_collision.wav")

var _ball: RigidBody2D

var _player_1_score := 0
var _player_2_score := 0

func _ready():
	_setup_goal_areas()
	_create_new_ball()
	_serve_ball_to_player(Player.Number.TWO)
	

func _setup_goal_areas() -> void:
	player_1_goal.body_entered.connect(_on_ball_entered_player_1_goal)
	player_2_goal.body_entered.connect(_on_ball_entered_player_2_goal)
	

func _on_ball_entered_player_1_goal(_body: Node2D) -> void:
	_player_2_score += 1
	_update_player_2_score_label()
	_play_score_sound()
	_reset_ball_and_serve.call_deferred(Player.Number.ONE)
	

func _on_ball_entered_player_2_goal(_body: Node2D) -> void:
	_player_1_score += 1
	_update_player_1_score_label()
	_play_score_sound()
	_reset_ball_and_serve.call_deferred(Player.Number.TWO)
	

func _create_new_ball() -> void:
	_ball = _ball_scene.instantiate()
	_ball.body_entered.connect(_on_ball_collision)
	player_1.ball = _ball
	player_2.ball = _ball
	ball_container.add_child(_ball)
	

func _on_ball_collision(body: Node2D) -> void:
	if body as Player:
		# Adding a random impulse to make the gameplay less stale
		_apply_random_paddle_impulse(body.player_number)
		_play_ball_paddle_hit_sound()
		return
	if body is StaticBody2D:
		_play_ball_wall_hit_sound()
	

func _apply_random_paddle_impulse(player_number: Player.Number) -> void:
	var rng = RandomNumberGenerator.new()
	var random_y = rng.randf_range(-3, 3)
	if (player_number == Player.Number.ONE):
		_ball.apply_impulse(Vector2(1, random_y))
	else:
		_ball.apply_impulse(Vector2(-1, random_y))
	

func _reset_ball_and_serve(player: Player.Number) -> void:
	_ball.queue_free()
	_create_new_ball()
	_serve_ball_to_player(player)
	

func _serve_ball_to_player(player: Player.Number) -> void:
	var rng = RandomNumberGenerator.new()
	var random_y = rng.randf_range(2, 5)
	if player == Player.Number.ONE:
		_ball.apply_impulse(Vector2(-5, random_y))
	else:
		_ball.apply_impulse(Vector2(5, random_y))
	

func _update_player_1_score_label() -> void:
	player_1_score_label.text = Util.int_to_string(_player_1_score)
	

func _update_player_2_score_label() -> void:
	player_2_score_label.text = Util.int_to_string(_player_2_score)
	

func _play_ball_wall_hit_sound() -> void:
	audio_player.stream = _wall_collision_audio
	audio_player.play()

func _play_ball_paddle_hit_sound() -> void:
	audio_player.stream = _paddle_collision_audio
	audio_player.play()

func _play_score_sound() -> void:
	audio_player.stream = _goal_audio
	audio_player.play()
