extends CanvasLayer

func _ready():
	resume()

func _process(delta):
	if Input.is_action_just_pressed("pause_menu"):
		if !get_tree().paused:
			pause()
		else:
			resume()
	
func pause():
	self.visible = true
	get_tree().set_deferred("paused", true)
	
func resume():
	self.visible = false
	get_tree().set_deferred("paused", false)
