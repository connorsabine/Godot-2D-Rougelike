extends CanvasLayer


# On Ready Variables
@onready var health : float = get_tree().get_nodes_in_group("players")[0].health
@onready var hunger : float = get_tree().get_nodes_in_group("players")[0].hunger

# On Ready Function
func _ready() -> void:
	var health_sb = StyleBoxFlat.new()
	$HealthBar.add_theme_stylebox_override("fill", health_sb)
	health_sb.bg_color = Color("ca2f0e")
	
	set_health_label(Global.MAX_HEALTH)
	set_health_bar(Global.MAX_HEALTH)
	
	var hunger_sb = StyleBoxFlat.new()
	$HungerBar.add_theme_stylebox_override("fill", hunger_sb)
	hunger_sb.bg_color = Color("ce6e09")
	
	set_hunger_label(Global.MAX_HUNGER)
	set_hunger_bar(Global.MAX_HUNGER)


# Run every delta time
func _process(delta: float) -> void:
	
	# Get player node and get health from it
	health = get_tree().get_nodes_in_group("players")[0].health
	set_health_bar(health)
	set_health_label(health)
	
	# Get player node and get hunger from it
	hunger = get_tree().get_nodes_in_group("players")[0].hunger
	set_hunger_bar(hunger)
	set_hunger_label(hunger)


# Update the health bar
func set_health_bar(health : float):
	$HealthBar.value = health


# Update the health label
func set_health_label(health : float):
	$HealthLabel.text = "Health: %s" % health


# Update the hunger bar
func set_hunger_bar(hunger : float):
	$HungerBar.value = hunger


# Update the hunger label
func set_hunger_label(hunger : float):
	$HungerLabel.text = "Hunger: %s" % hunger
