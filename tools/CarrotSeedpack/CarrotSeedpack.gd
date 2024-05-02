extends StaticBody2D

var seedtype = Global.TOOLTYPE.CARROT

func _ready():
	$AnimatedSprite2D.play("default")

func _on_area_2d_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click"):
		Global.SELECTEDTOOL = seedtype
