extends CharacterBody2D


# Exports
@export var inventory : Inventory
@export var SPEED : float = 300.0
@export var health : float = 5.0
@export var hunger : float = 10.0


# On Ready Variables
@onready var animation_tree = $AnimationTree


# Signals
#signal health_update
#signal hunger_update


# Preloading
var arrow = preload("res://projectiles/Arrow/arrow.tscn")


# Variables
var direction : Vector2 = Vector2.ZERO
var held_slot : int = 0 
var held_item
var attack_cooldown = true


# On Ready Function
func _ready():
	held_item = inventory.get_index(held_slot) 
	animation_tree.active = true
	$hunger_timer.start()


# Run every delta time
func _process(delta):
	update_animation_parameters()


func _physics_process(delta):
	
	# Movement
	direction = Input.get_vector("left", "right","up","down").normalized()
	if direction:
		velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO
	move_and_slide()
	
	# Bow and Arrow
	$Marker2D.look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("click") && held_item.name == "Bow" && attack_cooldown:
		var arrow_instance = arrow.instantiate()
		arrow_instance.rotation = $Marker2D.rotation
		arrow_instance.global_position = $Marker2D.global_position
		add_child(arrow_instance)
		
		attack_cooldown = false
		$attack_cooldown_timer.start()
		
	# Tools
	if Input.is_action_just_pressed("click"):
		# all other tools
		pass
	

# Hotbar Selection
func _input(event):
	if Input.is_action_just_pressed("hotbar_select_1"):
		held_slot = 0
		held_item = inventory.get_index(0)
	elif Input.is_action_just_pressed("hotbar_select_2"):
		held_slot = 1
		held_item = inventory.get_index(1) 
	elif Input.is_action_just_pressed("hotbar_select_3"):
		held_slot = 2
		held_item = inventory.get_index(2) 
	elif Input.is_action_just_pressed("hotbar_select_4"):
		held_slot = 3
		held_item = inventory.get_index(3) 
	elif Input.is_action_just_pressed("hotbar_select_5"):
		held_slot = 4
		held_item = inventory.get_index(4) 


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
	
	# update hotbar
	held_item = inventory.get_index(held_slot) 


# Remove Item from Inventory
func remove(item : InventoryItem):
	inventory.remove(item)
	
	# update hotbar
	held_item = inventory.get_index(held_slot) 


# Take Damage / Heal
func update_health(change : float):
	self.health += change
	if self.health > Global.MAX_HEALTH:
		self.health = Global.MAX_HEALTH
	if self.health <= 0:
		# die()
		# reset the player to beginning
		pass


# Gain / Remove Hunger
func update_hunger(change : float):
	self.hunger += change


# Remove 1/2 Hunger every 10 Seconds
func _on_hunger_timer_timeout() -> void:
	update_hunger(-0.5)
	$hunger_timer.start()


# Pickup Items (Set Collision Area Name to Item Name + "Pickup")
func _on_pickup_range_area_entered(area):
	if area in get_tree().get_nodes_in_group("collectable"):
		var item = area.get_name()
		collect(load("res://items/%s/%s.tres" % [item, item]))


# on cooldown timeout, set attack_cooldown to true, allowing more attacks
func _on_attack_cooldown_timer_timeout() -> void:
	attack_cooldown = true
