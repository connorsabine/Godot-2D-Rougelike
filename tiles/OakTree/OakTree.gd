extends StaticBody2D


# Variables
var oakwood = preload("res://items/OakWood/OakWood.tscn")
var health : int = 100


# Run every delta time
func _process(delta):
	if health <= 0:
		drop_wood(randi_range(2, 4))
		queue_free()


# On click on the area, remove health
func _on_area_2d_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click"):
		if Global.HELD_ITEM.name == "axe":
			health -= 25
		else:
			health -= 5


# Drop the items when the tree instance is removed
func drop_wood(num):
	for i in range(num):
		var oakwood_instance = oakwood.instantiate()
		oakwood_instance.global_position = Vector2i(($Marker2D.global_position.x + randi_range(-10, 10)),
			($Marker2D.global_position.y + randi_range(-10, 10)))
		get_parent().add_child(oakwood_instance)
