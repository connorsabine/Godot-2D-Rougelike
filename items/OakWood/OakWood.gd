extends StaticBody2D


func _on_oak_wood_area_entered(area):
	if area.get_name() == "Pickup":
		get_tree().create_timer(.1).timeout
		queue_free()
