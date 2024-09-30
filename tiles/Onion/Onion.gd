extends StaticBody2D


# Variables
var plant = preload("res://items/Onion/Onion.tscn")
var grown = false


# On Ready Function
func _ready():
	$Timer.start()


# On timer timeout, increment the animation
func _on_timer_timeout():
	if $AnimatedSprite2D.frame == 0:
		$AnimatedSprite2D.frame = 1
		$Timer.start()
	elif $AnimatedSprite2D.frame == 1:
		$AnimatedSprite2D.frame = 2
		grown = true


# On area click run drop and remove onion if grown
func _on_onion_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click") && grown:
		drop()
		queue_free()


# Drop the items and remove instance of onion
func drop():
	var instance = plant.instantiate()
	instance.global_position = Vector2i(($Marker2D.global_position.x + randi_range(-10, 10)),
		($Marker2D.global_position.y + randi_range(-10, 10)))
	get_parent().add_child(instance)
