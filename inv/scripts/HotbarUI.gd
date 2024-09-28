extends Control

@onready var inventory : Inventory = preload("res://player/inventory.tres")
@onready var slots : Array = $GridContainer.get_children()

func _ready():
	inventory.update.connect(update_slots)
	update_slots()
	
func update_slots():
	for i in range(min(inventory.slots.size(), slots.size())):
		slots[i].update(inventory.slots[i])
	
func _process(delta):
	pass
