extends Panel

@onready var visual : Sprite2D = $CenterContainer/Panel/ItemDisplay
@onready var amount : Label = $CenterContainer/Panel/Label

func update(slot: InventorySlot):
	if !slot.item:
		visual.visible = false
		amount.visible = false
	else:
		visual.visible = true
		visual.texture = slot.item.texture
		amount.visible = true
		amount.text = str(slot.amount)

func select():
	self_modulate = Color(20, 20, 20, 1.0)
	
func deselect():
	self_modulate = Color(.05, .05, .05, 1.0)
