extends CanvasLayer


# On Ready Function
func _ready() -> void:
	$Label.text = ""


# Run every delta time
func _process(delta: float) -> void:
	$Label.modulate = Color(1, 1, 1, $Timer.time_left/2)


# Set the tooltip to a string and start timer
func set_tooltip(text: String):
	$Label.text = text
	$Timer.start()


# Remove the tooltip on timeout of timer
func _on_timer_timeout() -> void:
	$Label.text = ""


# On signal from the hotbar changing, run set_tooltip
func _on_world_hotbar_selection_changed() -> void:
	set_tooltip(Global.HELD_ITEM.name.to_upper())
