extends Node2D


# On Ready Variables
@onready var tile_map : TileMap = $TileMap
@onready var inventory : Inventory = preload("res://player/inventory.tres")


# Variables
var ground_layer = 1
var enviorment_layer = 2


# Signals
signal hotbar_selection_changed


# On Ready
func _ready():
	pass


# Get all properties and methods of a class instance
func dir(class_instance):
	var output = {}
	var methods = []
	for method in class_instance.get_method_list():
		methods.append(method.name)
	output["METHODS"] = methods
	var properties = []
	for prop in class_instance.get_property_list():
		if prop.type == 3:
			properties.append(prop.name)
	output["PROPERTIES"] = properties
	return output


# Run every process
func _process(delta: float) -> void:
	update_global_held_item(Global.HELD_SLOT)


func update_global_held_item(index):
	Global.HELD_ITEM = inventory.get_index(index) 


func get_custom_data(tile_mouse_position, custom_data_layer, layer):
	var tile_data : TileData = tile_map.get_cell_tile_data(layer, tile_mouse_position)
	if tile_data:
		return tile_data.get_custom_data(custom_data_layer)
	else:
		return false


func _input(event):
	# Hotbar Selection
	if Input.is_action_just_pressed("hotbar_select_1"):
		Global.HELD_SLOT = 0
		update_global_held_item(Global.HELD_SLOT)
		hotbar_selection_changed.emit()
	elif Input.is_action_just_pressed("hotbar_select_2"):
		Global.HELD_SLOT = 1
		update_global_held_item(Global.HELD_SLOT)
		hotbar_selection_changed.emit()
	elif Input.is_action_just_pressed("hotbar_select_3"):
		Global.HELD_SLOT = 2
		update_global_held_item(Global.HELD_SLOT)
		hotbar_selection_changed.emit()
	elif Input.is_action_just_pressed("hotbar_select_4"):
		Global.HELD_SLOT = 3
		update_global_held_item(Global.HELD_SLOT)
		hotbar_selection_changed.emit()
	elif Input.is_action_just_pressed("hotbar_select_5"):
		Global.HELD_SLOT = 4
		update_global_held_item(Global.HELD_SLOT)
		hotbar_selection_changed.emit()
	
	# World Interaction
	if Input.is_action_just_pressed("click"):
		var tile_mouse_position : Vector2i = tile_map.local_to_map(get_global_mouse_position())
		tile_mouse_position = Vector2i(tile_mouse_position.x, tile_mouse_position.y+1)

		if Global.HELD_ITEM.name == "shovel":
			if get_custom_data(tile_mouse_position, "can_place_dirt", ground_layer):
				tile_map.set_cells_terrain_connect(ground_layer, [tile_mouse_position], 3, 0)
