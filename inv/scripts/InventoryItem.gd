extends Resource

class_name InventoryItem


# Exports
@export var name : String
@export var stackable : bool
@export var edible : bool
@export var level : float
@export var texture : Texture2D


# Check if an item is the same as self
func is_equal(item: InventoryItem):
	if self.name == item.name and self.stackable == item.stackable and self.edible == item.edible and self.level == item.level and self.texture == item.texture:
		return true
	return false
