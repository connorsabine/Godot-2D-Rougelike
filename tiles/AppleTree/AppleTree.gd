extends StaticBody2D


# Variables
var plant = preload("res://items/Apple/Apple.tscn")
var grown = false


# On ready
func _ready():
	$Timer.start()


# On timeout of timer, increment frames
func _on_timer_timeout():
	$AnimatedSprite2D.frame = 1


# If the area is clicked on and the frame is at max, run drop and reset frame
func _on_area_2d_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click") && $AnimatedSprite2D.frame == 1:
		$Timer.start()
		$AnimatedSprite2D.frame = 0
		drop()


# Spawn in a instance of the apple item
func drop():
	var instance = plant.instantiate()
	instance.global_position = Vector2i(($Marker2D.global_position.x + randi_range(-10, 10)),
		($Marker2D.global_position.y + randi_range(-10, 10)))
	get_parent().add_child(instance)
