extends StaticBody2D

var plant = Global.plantselected
var plantgrowing = false
var plantgrown = false

func _physics_process(delta):
	if plantgrowing == false:
		plant = Global.plantselected

func _on_area_2d_area_entered(area):
	if not plantgrowing:
		if plant == 1:
			plantgrowing = true
			$carrotgrowtimer.start()
			$Plant.play("carrot")
		if plant == 2:
			plantgrowing = true
			$oniongrowtimer.start()
			$Plant.play("onion")
	else:
		print("plant already growing here")


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
