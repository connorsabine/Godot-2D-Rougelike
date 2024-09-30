extends CanvasLayer


func _ready() -> void:
	$Label.text = ""


func _process(delta: float) -> void:
	# reduce the visibility of the text box 
	pass


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
