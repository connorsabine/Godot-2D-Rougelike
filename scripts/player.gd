extends CharacterBody2D

# Exports
@export var inventory : Inventory
@export var SPEED : float = 300.0


# Variables
var direction : Vector2 = Vector2.ZERO

# On Ready Variables
@onready var animation_tree = $AnimationTree

# On Ready Function
func _ready():
	animation_tree.active = true

func _process(delta):
	update_held_item()
	#inventory.update.connect(update_held_item())
	#get_parent().hotbar_update.connect(update_held_item())
	update_animation_parameters()

# Simple Movement
func _physics_process(delta):
	direction = Input.get_vector("left", "right","up","down").normalized()
	if direction:
		velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO

	move_and_slide()
	


# Update Animation Directions
func update_animation_parameters():
	if(velocity == Vector2.ZERO):
		animation_tree["parameters/conditions/is_idle"] = true
		animation_tree["parameters/conditions/is_moving"] = false
	else:
		animation_tree["parameters/conditions/is_idle"] = false
		animation_tree["parameters/conditions/is_moving"] = true

	if direction != Vector2.ZERO:
		animation_tree["parameters/idle/blend_position"] = direction
		animation_tree["parameters/walk/blend_position"] = direction
	
	
# Update to the currently held item
func update_held_item():
	Global.CURRENT_ITEM = inventory.get_index(Global.SELECTED_HOTBAR_SLOT)
	
	

# Add Item to Inventory
func collect(item):
	inventory.insert(item)
	

# Pickup Items (Set Collision Area Name to Item Name + Pickup)
func _on_pickup_range_area_entered(area):
	if "Pickup" in area.get_name():
		var item = area.get_name().replace("Pickup", "")
		collect(load("res://items/%s/%s.tres" % [item, item]))
