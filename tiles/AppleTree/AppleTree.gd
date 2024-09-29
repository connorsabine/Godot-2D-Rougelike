extends StaticBody2D

var plant = preload("res://items/Apple/Apple.tscn")
var grown = false

func _ready():
	$Timer.start()

func _on_timer_timeout():
	$AnimatedSprite2D.frame = 1

func _on_area_2d_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click") && $AnimatedSprite2D.frame == 1:
		$Timer.start()
		$AnimatedSprite2D.frame = 0
		drop()

func drop():
	var instance = plant.instantiate()
	instance.global_position = Vector2i(($Marker2D.global_position.x + randi_range(-10, 10)),
		($Marker2D.global_position.y + randi_range(-10, 10)))
	get_parent().add_child(instance)
