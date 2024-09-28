extends Resource

class_name Inventory

signal update

@export var slots : Array[InventorySlot]

# Load in Inventory Slot
var InventorySlot = preload("res://inv/scripts/InventorySlot.gd")

func insert(item: InventoryItem):
	var itemslots = slots.filter(func(slot): return slot.item == item)
	if !itemslots.is_empty() && item.stackable:
		itemslots[0].amount += 1
	else:
		var emptyslots = slots.filter(func(slot): return slot.item == null)
		if !emptyslots.is_empty():
			emptyslots[0].item = item
			emptyslots[0].amount = 1
	update.emit()
	
	
func remove(index: int):
	if slots[index].amount > 1:
		slots[index].amount -= 1
	else:
		slots[index] = InventorySlot.new()
	update.emit()


func get_index(index: int):
	if index >= 0 and index < slots.size():
		if slots[index].item:
			return slots[index].item.name
		return null
	return null


func get_all():
	return slots
		
