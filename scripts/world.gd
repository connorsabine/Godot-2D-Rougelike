extends Node2D

@onready var tile_map : TileMap = $TileMap

var ground_layer = 1
var enviorment_layer = 2
var farm_land_vector =  Vector2i(4, 7)

signal hotbar_update

func _ready():
	pass
	

func get_custom_data(tile_mouse_position, custom_data_layer, layer):
	var tile_data : TileData = tile_map.get_cell_tile_data(layer, tile_mouse_position)
	if tile_data:
		return tile_data.get_custom_data(custom_data_layer)
	else:
		return false
		

func _input(event):
	# Hotbar Selection
	if Input.is_action_just_pressed("hotbar_select_1"):
		Global.SELECTED_HOTBAR_SLOT = 0
		hotbar_update.emit()
	elif Input.is_action_just_pressed("hotbar_select_2"):
		Global.SELECTED_HOTBAR_SLOT = 1
		hotbar_update.emit()
	elif Input.is_action_just_pressed("hotbar_select_3"):
		Global.SELECTED_HOTBAR_SLOT = 2
		hotbar_update.emit()
	elif Input.is_action_just_pressed("hotbar_select_4"):
		Global.SELECTED_HOTBAR_SLOT = 3
		hotbar_update.emit()
	elif Input.is_action_just_pressed("hotbar_select_5"):
		Global.SELECTED_HOTBAR_SLOT = 4
		hotbar_update.emit()
	
	# World Interaction
	if Input.is_action_just_pressed("click"):
		var tile_mouse_position : Vector2i = tile_map.local_to_map(get_global_mouse_position())
		tile_mouse_position = Vector2i(tile_mouse_position.x, tile_mouse_position.y+1)

		if Global.CURRENT_ITEM == "shovel":
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
