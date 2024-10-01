extends CharacterBody2D


# Exports
@export var HEALTH : float = 3


# Variables
var states = {"idling":false, "walking":false, "chasing":false, "dead":false}
var direction = {"x":1, "y":1}
var speed = 15
var moving = 1
var chase_distance = 100


# On Ready Function
func _ready():
	states["walking"] = true


# Hitting the Slime
# On click on the area, remove health
func _on_area_2d_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click"):
		self.HEALTH -= 1
		if self.HEALTH <= 0:
			die()


# Walking & Idling Animations and Movement
func _physics_process(delta):
	var wait = 1
	if not states["dead"]:
		if states["chasing"]:
			$AnimatedSprite2D.play("walk")
			if distance(get_player_x(), self.position.x) > 0:
				velocity.x = speed
			else:
				velocity.x = -speed
				
			if distance(get_player_y(), self.position.y) > 0:
				velocity.y = speed
			else:
				velocity.y = -speed
			
		if states["walking"]:
			if randi_range(1, 2) > 1.5:
				moving = 1
			else:
				moving = 2
			$AnimatedSprite2D.play("walk")
			if moving == 1:
				#if direction["x"] == -1:
					#$AnimatedSprite2D.flip_h = true
				#if direction["x"] == 1:
					#$AnimatedSprite2D.flip_h = false
				velocity.x = speed * direction["x"]
				velocity.y = 0
			elif moving == 2:
				velocity.y = speed * direction["y"]
				velocity.x = 0
		if states["idling"]:
			$AnimatedSprite2D.play("idling")
			velocity.x = 0
			velocity.y = 0
		move_and_slide()


func die():
	states["dead"] = true
	$AnimatedSprite2D.play("die")
	await get_tree().create_timer(1).timeout
	self.queue_free()
	

func distance_from_self(x, y):
	return ((x-self.position.x)**2+(y-self.position.y)**2)**(0.5)


func distance(a, b):
	return a - b
	

func get_player_x():
	return get_tree().get_nodes_in_group("players")[0].position.x


func get_player_y():
	return get_tree().get_nodes_in_group("players")[0].position.y


# Select a new state on timeout
func _on_state_timeout():
	var wait = 1
	if distance_from_self(get_player_x(), get_player_y()) <= chase_distance:
		states["chasing"] = true
		states["walking"] = false
		states["idling"] = false
	else:
		if randi_range(1,2) > 1.5:
			states["idling"] = true
			states["walking"] = false
			states["chasing"] = false
			wait = randi_range(1, 4)
		else:
			states["walking"] = true
			states["chasing"] = false
			states["idling"] = false
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
