extends Control

@onready var inventory : Inventory = preload("res://player/inventory.tres")
@onready var slots : Array = $GridContainer.get_children()

var selected = Global.HELD_SLOT

func _ready():
	# Start Inventory Updates
	inventory.update.connect(update_slots)
	update_slots()
	
	# Set Selected Slot
	$GridContainer.get_child(Global.HELD_SLOT).select()
	
func _process(delta):
	update_selected_slot()
		
func update_selected_slot():
	if selected != Global.HELD_SLOT:
		$GridContainer.get_child(selected).deselect()
		$GridContainer.get_child(Global.HELD_SLOT).select()
		selected = Global.HELD_SLOT
	
func update_slots():
	for i in range(min(inventory.slots.size(), slots.size())):
		slots[i].update(inventory.slots[i])
	
