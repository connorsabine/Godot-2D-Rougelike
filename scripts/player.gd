extends CharacterBody2D


# Exports
@export var inventory : Inventory
@export var SPEED : float = 300.0
@export var health : float = 5.0
@export var hunger : float = 10.0


# Signals
signal health_update
signal hunger_update


# Variables
var direction : Vector2 = Vector2.ZERO


# On Ready Variables
@onready var animation_tree = $AnimationTree


# On Ready Function
func _ready():
	animation_tree.active = true


# Run every delta time
func _process(delta):
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


# Add Item to Inventory
func collect(item : InventoryItem):
	inventory.insert(item)


# Remove Item from Inventory
func remove(item : InventoryItem):
	inventory.remove(item)


# Take Damage / Heal
func update_health(change : float):
	self.health += change
	if self.health > Global.MAX_HEALTH:
		self.health = Global.MAX_HEALTH
	if self.health <= 0:
		# die()
		# reset the player to beginning
		pass
	health_update.emit()


# Gain / Remove Hunger
func update_hunger(change : float):
	self.hunger += change
	hunger_update.emit()


# Pickup Items (Set Collision Area Name to Item Name + "Pickup")
func _on_pickup_range_area_entered(area):
	if "Pickup" in area.get_name():
		var item = area.get_name().replace("Pickup", "")
		collect(load("res://items/%s/%s.tres" % [item, item]))
