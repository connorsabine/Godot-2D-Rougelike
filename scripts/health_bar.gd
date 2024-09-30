extends CanvasLayer


# On Ready Function
func _ready() -> void:
	pass


# Run every delta time
func _process(delta: float) -> void:
	
	# Get player node and get health from it
	update_health_display(get_tree().get_nodes_in_group("players")[0].health)


# Update the health display
func update_health_display(hearts : int):
	if hearts == 5:
		$Heart.visible = true
		$Heart2.visible = true
		$Heart3.visible = true
		$Heart4.visible = true
		$Heart5.visible = true
	elif hearts == 4:
		$Heart.visible = true
		$Heart2.visible = true
		$Heart3.visible = true
		$Heart4.visible = true
		$Heart5.visible = false
	elif hearts == 3:
		$Heart.visible = true
		$Heart2.visible = true
		$Heart3.visible = true
		$Heart4.visible = false
		$Heart5.visible = false
	elif hearts == 2:
		$Heart.visible = true
		$Heart2.visible = true
		$Heart3.visible = false
		$Heart4.visible = false
		$Heart5.visible = false
	elif hearts == 1:
		$Heart.visible = true
		$Heart2.visible = false
		$Heart3.visible = false
		$Heart4.visible = false
		$Heart5.visible = false
	else:
		$Heart.visible = false
		$Heart2.visible = false
		$Heart3.visible = false
		$Heart4.visible = false
		$Heart5.visible = false
