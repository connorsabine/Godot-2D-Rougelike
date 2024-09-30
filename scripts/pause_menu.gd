extends CanvasLayer


# On Ready Function
func _ready():
	resume()


# Pause game if menu opened
func _process(delta):
	if Input.is_action_just_pressed("pause_menu"):
		if !get_tree().paused:
			pause()
		else:
			resume()


# Pause the game
func pause():
	self.visible = true
	get_tree().set_deferred("paused", true)


# Unpause the game
func resume():
	self.visible = false
	get_tree().set_deferred("paused", false)
