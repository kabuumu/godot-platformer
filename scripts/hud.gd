extends CanvasLayer

@onready var health_bar = $HealthBar
@onready var health_label = $HealthBar/HealthLabel

var max_health = 28
var current_health = 28

func _ready():
	update_health_display()

func set_health(value):
	current_health = clamp(value, 0, max_health)
	update_health_display()

func update_health_display():
	health_label.text = "ENERGY"
	# Update health bar segments
	var segments = current_health
	# Health bar will be styled with TextureRect nodes in the scene
