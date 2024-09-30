extends StaticBody2D


# Variables
var plant = preload("res://items/Carrot/Carrot.tscn")
var grown = false


# On Ready Function
func _ready():
	$Timer.start()


# On timer timeout, increment animation frame
func _on_timer_timeout():
	if $AnimatedSprite2D.frame == 0:
		$AnimatedSprite2D.frame = 1
		$Timer.start()
	elif $AnimatedSprite2D.frame == 1:
		$AnimatedSprite2D.frame = 2
		grown = true


# Drop item on click event if it is fully grown
func _on_carrot_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click") && grown:
		drop()
		queue_free()

func drop():
	var instance = plant.instantiate()
	instance.global_position = Vector2i(($Marker2D.global_position.x + randi_range(-10, 10)),
		($Marker2D.global_position.y + randi_range(-10, 10)))
	get_parent().add_child(instance)
