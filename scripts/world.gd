extends Node2D

@onready var tile_map : TileMap = $TileMap

var ground_layer = 1
var enviorment_layer = 2

enum FARMING_MODES {SEED, DIRT}

var current_farming_mode = FARMING_MODES.DIRT

var dirt_tiles = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _input(event):
	if Input.is_action_just_pressed("toggle_dirt"):
		current_farming_mode = FARMING_MODES.DIRT
	if Input.is_action_just_pressed("toggle_seed"):
		current_farming_mode = FARMING_MODES.SEED
	if Input.is_action_just_pressed("click"):
		var tile_mouse_position : Vector2i = tile_map.local_to_map(get_global_mouse_position())
		var source_id : int = 0
			
		if current_farming_mode == FARMING_MODES.SEED:
			var atlas_coord : Vector2i = Vector2i(11, 1)
			if get_custom_data(tile_mouse_position, "can_place_seeds", ground_layer):
				tile_map.set_cell(enviorment_layer, tile_mouse_position, source_id, atlas_coord)
				var level : int = 0
				var final_seed_level : int = 3
				handle_seed(tile_mouse_position, level, atlas_coord, final_seed_level)
		if current_farming_mode == FARMING_MODES.DIRT:
			if get_custom_data(tile_mouse_position, "can_place_dirt", ground_layer):
				dirt_tiles.append(tile_mouse_position)
				tile_map.set_cells_terrain_connect(ground_layer, dirt_tiles, 3, 0)
			
			
func get_custom_data(tile_mouse_position, custom_data_layer, layer):
	var tile_data : TileData = tile_map.get_cell_tile_data(layer, tile_mouse_position)
	if tile_data:
		return tile_data.get_custom_data(custom_data_layer)
	else:
		return false
		
		
func handle_seed(tile_map_position, level, atlas_coord, final_seed_level):
	var source_id : int = 0
	tile_map.set_cell(enviorment_layer, tile_map_position, source_id, atlas_coord)
	await get_tree().create_timer(5).timeout
	if level == final_seed_level:
		return
	else:
		var new_atlas_coord : Vector2i = Vector2i(atlas_coord.x+1, atlas_coord.y)
		tile_map.set_cell(enviorment_layer, tile_map_position, source_id, new_atlas_coord)
		handle_seed(tile_map_position, level+1, new_atlas_coord, final_seed_level)

