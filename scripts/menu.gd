extends Control

signal new_game_pressed()
signal quit_pressed()

@export var new_game_button: Button
@export var restart_button: Button
@export var quit_button: Button

var _game_scene = load("res://scenes/game.tscn")

var _has_started_game := false

func _ready():
	_setup_buttons()

func _setup_buttons() -> void:
	new_game_button.pressed.connect(_on_new_game_pressed)
	restart_button.pressed.connect(_on_reset_pressed)
	quit_button.pressed.connect(_on_quit_pressed)

func _on_new_game_pressed() -> void:
	if _has_started_game:
		get_tree().paused = false
		get_tree().root.get_child(2).visible = true
		get_tree().current_scene = get_tree().root.get_child(2)
		self.visible = false
	else:
		restart_button.visible = true
		_setup_new_game()
		new_game_button.text = "Resume"
		self.visible = false
		_has_started_game = true
	

func _on_reset_pressed() -> void:
	get_tree().root.remove_child(get_tree().root.get_child(2))
	_has_started_game = false
	_on_new_game_pressed()
	get_tree().paused = false

func _on_quit_pressed() -> void:
	get_tree().quit()

func _setup_new_game() -> void:
	var new_game = _game_scene.instantiate()
	new_game.game_paused.connect(_game_paused)
	get_tree().root.add_child(new_game)

func _game_paused() -> void:
	get_tree().paused = true
	get_tree().root.get_child(2).visible = false
	self.visible = true
