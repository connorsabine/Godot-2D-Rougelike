extends Control


# On Ready Variables
@onready var inventory : Inventory = preload("res://player/inventory.tres")
@onready var slots : Array = $GridContainer.get_children()


# Variables
var selected = Global.HELD_SLOT


func _ready():
	# Start Inventory Updates
	inventory.update.connect(update_slots)
	update_slots()
	
	# Set Selected Slot
	$GridContainer.get_child(Global.HELD_SLOT).select()


# Run every delta time
func _process(delta):
	update_selected_slot()


# Update the slot to be selected
func update_selected_slot():
	if selected != Global.HELD_SLOT:
		$GridContainer.get_child(selected).deselect()
		$GridContainer.get_child(Global.HELD_SLOT).select()
		selected = Global.HELD_SLOT


# Update all slots to contain the correct inventory items
func update_slots():
	for i in range(min(inventory.slots.size(), slots.size())):
		slots[i].update(inventory.slots[i])
	
