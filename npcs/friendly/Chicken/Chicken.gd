extends CharacterBody2D


# Variables
var states = {"eating":false, "walking":false}
var direction = {"x":1, "y":1}
var speed = 15
var moving = 1 # 1 = horizontal 2 = vertical


# On Ready Function
func _ready():
	states["walking"] = true


# Walking & Eating Animations and Movement
func _physics_process(delta):
	var wait = 1
	if states["walking"]:
		if randi_range(1, 2) > 1.5:
			moving = 1
		else:
			moving = 2
		
		$AnimatedSprite2D.play("walk")
		if moving == 1:
			if direction["x"] == -1:
				$AnimatedSprite2D.flip_h = true
			if direction["x"] == 1:
				$AnimatedSprite2D.flip_h = false
			velocity.x = speed * direction["x"]
			velocity.y = 0
		elif moving == 2:
			velocity.y = speed * direction["y"]
			velocity.x = 0
	if states["eating"]:
		$AnimatedSprite2D.play("eating")
		velocity.x = 0
		velocity.y = 0
		
	move_and_slide()


# Select a new state on timeout
func _on_state_timeout():
	var wait = 1
	if states["walking"]:
		states["eating"] = true
		states["walking"] = false
		wait = randi_range(1, 5)
	elif states["eating"]:
		states["walking"] = true
		states["eating"] = false
		wait = randi_range(2, 6)
	$state.wait_time = wait
	$state.start()


func _on_walk_timeout():
	var x = randi_range(1, 2)
	var y = randi_range(1, 2)
	var wait = randi_range(1, 4)
	if x > 1.5:
		direction["x"] = 1
	else:
		direction["x"] = -1
	if y > 1.5:
		direction["y"] = 1
	else:
		direction["y"] = -1
	$walk.wait_time = wait
	$walk.start()
