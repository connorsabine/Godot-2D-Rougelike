extends StaticBody2D

var selected = Global.SELECTEDTOOL
var plantgrowing = false
var plantgrown = false

var carrot = preload("res://farming/items/Carrot.tscn")
var onion = preload("res://farming/items/Onion.tscn")

func _process(delta):
	if plantgrowing == false:
		selected = Global.SELECTEDTOOL

func _on_carrotgrowtimer_timeout():
	var carrot_plant = $Plant
	if carrot_plant.frame == 0:
		carrot_plant.frame = 1
		$carrotgrowtimer.start()
	elif carrot_plant.frame == 1:
		carrot_plant.frame = 2
		plantgrown = true
	
func _on_oniongrowtimer_timeout():
	var onion_plant = $Plant
	if onion_plant.frame == 0:
		onion_plant.frame = 1
		$oniongrowtimer.start()
	elif onion_plant.frame == 1:
		onion_plant.frame = 2
		plantgrown = true
		

func _on_area_2d_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click"):
		if not plantgrowing:
			if selected == Global.TOOLTYPE.CARROT:
				plantgrowing = true
				$carrotgrowtimer.start()
				$Plant.play("carrot")
			elif selected == Global.TOOLTYPE.ONION:
				plantgrowing = true
				$oniongrowtimer.start()
				$Plant.play("onion")
			else:
				pass
		
		elif plantgrown:
			if selected == Global.TOOLTYPE.CARROT:
				plantgrowing = false
				plantgrown = false
				$Plant.play("none")
				drop_carrot()
			elif selected == Global.TOOLTYPE.ONION:
				plantgrowing = false
				plantgrown = false
				$Plant.play("none")
				drop_onion()
			else:
				pass
		else:
			pass


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
