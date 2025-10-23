extends Camera2D

# Camera deadzone settings - camera only moves when player exits these bounds
# These values define a box around the current camera center (in pixels)
@export var deadzone_width = 64.0  # Horizontal deadzone (32 pixels each side from center)
@export var deadzone_height = 48.0  # Vertical deadzone (24 pixels each side from center)

# Smoothing speed for Y-axis camera movement (X-axis follows instantly like Mega Man)
@export var follow_speed = 5.0

# Target position for smooth camera movement
var target_position = Vector2.ZERO

func _ready():
	# Initialize target position to current camera position
	target_position = global_position
	# Disable built-in smoothing as we're doing custom smoothing
	position_smoothing_enabled = false

func _process(delta):
	# Get the player (parent node)
	var player = get_parent() as CharacterBody2D
	if not player:
		return
	
	# Calculate player position relative to camera center
	var player_offset = player.global_position - target_position
	
	# Calculate deadzone boundaries
	var half_deadzone_width = deadzone_width / 2.0
	var half_deadzone_height = deadzone_height / 2.0
	
	# Adjust target position if player is outside deadzone
	# Horizontal deadzone check
	if player_offset.x > half_deadzone_width:
		target_position.x += player_offset.x - half_deadzone_width
	elif player_offset.x < -half_deadzone_width:
		target_position.x += player_offset.x + half_deadzone_width
	
	# Vertical deadzone check
	if player_offset.y > half_deadzone_height:
		target_position.y += player_offset.y - half_deadzone_height
	elif player_offset.y < -half_deadzone_height:
		target_position.y += player_offset.y + half_deadzone_height
	
	# Move camera towards target position
	# X-axis follows perfectly (like Mega Man), Y-axis is smoothed
	global_position.x = target_position.x
	global_position.y = lerp(global_position.y, target_position.y, follow_speed * delta)
	
	# Snap to nearest pixel for pixel-perfect rendering
	global_position = global_position.round()
