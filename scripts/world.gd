extends Node2D

@onready var tile_map : TileMap = $TileMap
@onready var inventory : Inventory = preload("res://player/inventory.tres")
@onready var slots : Array = $hotbar/HotbarUI/GridContainer.get_children()

var ground_layer = 1
var enviorment_layer = 2
var farm_land_vector =  Vector2i(4, 7)


func _ready():
	pass
	
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
	
func update_hotbar_data():
	for i in range(4):
		slots[i].update(inventory.slots[i])
	
func update_selected_item(index):
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
		update_selected_item(0)
		Global.HELD_SLOT = 0
	elif Input.is_action_just_pressed("hotbar_select_2"):
		update_selected_item(1)
		Global.HELD_SLOT = 1
	elif Input.is_action_just_pressed("hotbar_select_3"):
		update_selected_item(2)
		Global.HELD_SLOT = 2
	elif Input.is_action_just_pressed("hotbar_select_4"):
		update_selected_item(3)
		Global.HELD_SLOT = 3
	elif Input.is_action_just_pressed("hotbar_select_5"):
		update_selected_item(4)
		Global.HELD_SLOT = 4
	
	# World Interaction
	if Input.is_action_just_pressed("click"):
		var tile_mouse_position : Vector2i = tile_map.local_to_map(get_global_mouse_position())
		tile_mouse_position = Vector2i(tile_mouse_position.x, tile_mouse_position.y+1)

		if Global.HELD_ITEM == "shovel":
			if get_custom_data(tile_mouse_position, "can_place_dirt", ground_layer):
				tile_map.set_cells_terrain_connect(ground_layer, [tile_mouse_position], 3, 0)
				#
		#if Global.CURRENT_ITEM == "hoe":
			#if get_custom_data(tile_mouse_position, "can_hoe_dirt", ground_layer):
				#tile_map.set_cell(ground_layer, tile_mouse_position, 1, farm_land_vector)
		#
		#if Global.CURRENT_ITEM == "carrot":
			#if get_custom_data(tile_mouse_position, "can_farm", ground_layer):
				#var instance = load("res://tiles/Carrot/Carrot.tscn").instantiate()
				#instance.position = Vector2((tile_mouse_position[0])*Global.TILESIZE + Global.TILESIZE/2, 
					#(tile_mouse_position[1]-1)*Global.TILESIZE + Global.TILESIZE/2)
				#get_parent().add_child(instance)
				#
		#if Global.CURRENT_ITEM == "onion":
			#if get_custom_data(tile_mouse_position, "can_farm", ground_layer):
				#var instance = load("res://tiles/Onion/Onion.tscn").instantiate()
				#instance.position = Vector2((tile_mouse_position[0])*Global.TILESIZE + Global.TILESIZE/2, 
					#(tile_mouse_position[1]-1)*Global.TILESIZE + Global.TILESIZE/2)
				#get_parent().add_child(instance)
