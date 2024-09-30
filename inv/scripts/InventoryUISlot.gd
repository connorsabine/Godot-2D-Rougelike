extends Panel


# On Ready Variables
@onready var visual : Sprite2D = $CenterContainer/Panel/ItemDisplay
@onready var amount : Label = $CenterContainer/Panel/Label


# Update the inventory to show the items
func update(slot: InventorySlot):
	if !slot.item:
		visual.visible = false
		amount.visible = false
	else:
		visual.visible = true
		visual.texture = slot.item.texture
		amount.visible = true
		
		if slot.amount == 0 or slot.amount == 1: 
			amount.text = ""
		else: 
			amount.text = str(slot.amount)


# Update the brightness of the slot to show it is selected
func select():
	self_modulate = Color(20, 20, 20, 1.0)


# Update the brightness of the slot back to normal, deselecting it
func deselect():
	self_modulate = Color(.05, .05, .05, 1.0)
