extends Node2D


# On Ready Variables
@onready var tile_map : TileMap = $TileMap


# Variables
var ground_layer = 1
var enviorment_layer = 2


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
	pass


func get_custom_data(tile_mouse_position, custom_data_layer, layer):
	var tile_data : TileData = tile_map.get_cell_tile_data(layer, tile_mouse_position)
	if tile_data:
		return tile_data.get_custom_data(custom_data_layer)
	else:
		return false


func _input(event):
	# World Interaction
	if Input.is_action_just_pressed("click"):
		var player_position : Vector2  = $Player.position
		var global_mouse_position : Vector2 = get_global_mouse_position()
		var tile_mouse_position : Vector2i = tile_map.local_to_map(global_mouse_position)
		tile_mouse_position = Vector2i(tile_mouse_position.x, tile_mouse_position.y+1)
