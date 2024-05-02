extends StaticBody2D

var state = {"growing":false, "grown":false}

var on_farming_cooldown : bool = false
var carrot = preload("res://items/Carrot/Carrot.tscn")
var onion = preload("res://items/Onion/Onion.tscn")

func _on_carrotgrowtimer_timeout():
	if $Plant.frame == 0:
		$Plant.frame = 1
		$carrotgrowtimer.start()
	elif $Plant.frame == 1:
		$Plant.frame = 2
		state["grown"] = true


func _on_oniongrowtimer_timeout():
	if $Plant.frame == 0:
		$Plant.frame = 1
		$oniongrowtimer.start()
	elif $Plant.frame == 1:
		$Plant.frame = 2
		state["grown"] = true
		

func _on_farmingcooldown_timeout():
	on_farming_cooldown = false

func _on_area_2d_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click") && not on_farming_cooldown:
		if not state["growing"]:
			if Global.SELECTEDTOOL == Global.TOOLTYPE.CARROT:
				state["growing"] = true
				$carrotgrowtimer.start()
				$Plant.play("carrot")
			elif Global.SELECTEDTOOL == Global.TOOLTYPE.ONION:
				state["growing"] = true
				$oniongrowtimer.start()
				$Plant.play("onion")
			else:
				pass
		
		elif state["grown"]:
			if Global.SELECTEDTOOL == Global.TOOLTYPE.CARROT:
				state["growing"] = false
				state["grown"] = false
				$Plant.play("none")
				drop_carrot()
			elif Global.SELECTEDTOOL == Global.TOOLTYPE.ONION:
				state["growing"] = false
				state["grown"] = false
				$Plant.play("none")
				drop_onion()
			else:
				pass
			
		else:
			pass
		
		# start farming cooldown
		$farmingcooldown.start()
		on_farming_cooldown = true


func drop_onion():
	var plant_instance = onion.instantiate()
	plant_instance.global_position = Vector2i(($Marker2D.global_position.x + randi_range(-10, 10)),
		($Marker2D.global_position.y + randi_range(-10, 10)))
	get_parent().add_child(plant_instance)


func drop_carrot():
	var plant_instance = carrot.instantiate()
	plant_instance.global_position = Vector2i(($Marker2D.global_position.x + randi_range(-10, 10)),
		($Marker2D.global_position.y + randi_range(-10, 10)))
	get_parent().add_child(plant_instance)
