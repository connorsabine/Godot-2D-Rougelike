extends Resource

class_name Inventory

signal update

# Exports
@export var slots : Array[InventorySlot]


# Insert an item into the inventory
# Finds item, if found, increments the item slot amount
# If not found, add it to a new item slot
func insert(item: InventoryItem):
	var itemslots = slots.filter(func(slot): return slot.item == item)
	
	if !itemslots.is_empty() && item.stackable:
		itemslots[0].amount += 1
	else:
		var emptyslots = slots.filter(func(slot): return slot.item.is_equal(InventoryItem.new()))
		if !emptyslots.is_empty():
			emptyslots[0].item = item
			emptyslots[0].amount = 1
	
	update.emit()


# Remove one of an item from the inventory, if amount of item is 0 reset the InventorySlot.
# Returns true if item is found and 1 is removed from the stack
# Returns false if the item cannot be found and is not removed
func remove(item: InventoryItem):
	var itemslots = slots.filter(func(slot): return slot.item == item)
	if !itemslots.is_empty() && item.stackable:
		itemslots[0].amount -= 1
		
		# If amount of items 0 or less, replace the item slot
		if itemslots[0].amount <= 0:
			itemslots[0] = InventorySlot.new()
			
		return true
		
	# Return false if cant remove item
	else:
		return false
		
	# Emit inventory update
	update.emit()


# Returns the item at a specific index or returns null if there is no item
func get_index(index: int):
	if index >= 0 and index < slots.size():
		if slots[index].item:
			return slots[index].item
		return null
	return null


# Returns the entire array of slots
func get_all():
	return slots
		
