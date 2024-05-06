extends Control

@onready var inventory : Inventory = preload("res://player/inventory.tres")
@onready var slots : Array = $NinePatchRect/GridContainer.get_children()

var is_open : bool = false

func _ready():
	inventory.update.connect(update_slots)
	update_slots()
	close()
	
func update_slots():
	for i in range(min(inventory.slots.size(), slots.size())):
		slots[i].update(inventory.slots[i])
	
func _process(delta):
	if Input.is_action_just_pressed("inventory"):
		if is_open:
			close()
		else:
			open()
	
func open():
	self.visible = true
	is_open = true
	
func close():
	self.visible = false
	is_open = false
