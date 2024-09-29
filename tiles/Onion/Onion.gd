extends StaticBody2D

var plant = preload("res://items/Onion/Onion.tscn")
var grown = false

func _ready():
	$Timer.start()

func _on_timer_timeout():
	if $AnimatedSprite2D.frame == 0:
		$AnimatedSprite2D.frame = 1
		$Timer.start()
	elif $AnimatedSprite2D.frame == 1:
		$AnimatedSprite2D.frame = 2
		grown = true

func _on_onion_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click") && grown:
		drop()
		queue_free()

func drop():
	var instance = plant.instantiate()
	instance.global_position = Vector2i(($Marker2D.global_position.x + randi_range(-10, 10)),
		($Marker2D.global_position.y + randi_range(-10, 10)))
	get_parent().add_child(instance)
