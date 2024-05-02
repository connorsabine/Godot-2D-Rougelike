extends CanvasLayer

@export var can_toggle_pause : bool = true

func _ready():
	resume()

func _process(delta):
	if Input.is_action_just_pressed("pause_menu"):
		if !get_tree().paused:
			pause()
		else:
			resume()
	
func pause():
	if can_toggle_pause:
		self.visible = true
		get_tree().set_deferred("paused", true)
	
func resume():
	if can_toggle_pause:
		self.visible = false
		get_tree().set_deferred("paused", false)
