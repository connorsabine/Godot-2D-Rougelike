extends Control


# On Ready Variables
@onready var inventory : Inventory = preload("res://player/inventory.tres")
@onready var slots : Array = $NinePatchRect/GridContainer.get_children()


# Signals
signal inventory_update


# Variables
var is_open : bool = false


# On Ready Function
func _ready():
	inventory.update.connect(update_slots)
	update_slots()
	close()


# Update slots to have correct inventory items
func update_slots():
	for i in range(min(inventory.slots.size(), slots.size())):
		slots[i].update(inventory.slots[i])
	

# Run every delta time
func _process(delta):
	if Input.is_action_just_pressed("inventory"):
		if is_open:
			close()
		else:
			open()


# Open the inventory
func open():
	self.visible = true
	is_open = true


# Close the inventory
func close():
	self.visible = false
	is_open = false
