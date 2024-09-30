extends CanvasLayer


# On Ready Variables
@onready var health : float = get_tree().get_nodes_in_group("players")[0].health


# On Ready Function
func _ready() -> void:
	set_health_label(Global.MAX_HEALTH)
	set_health_bar(Global.MAX_HEALTH)


# Run every delta time
func _process(delta: float) -> void:
	
	# Get player node and get health from it
	health = get_tree().get_nodes_in_group("players")[0].health
	set_health_bar(health)
	set_health_label(health)


# Update the health bar
func set_health_bar(health : float):
	$ProgressBar.value = health


# Update the health label
func set_health_label(health : float):
	$Label.text = "Health: %s" % health
