extends CharacterBody2D

const SPEED = 30.0
const GRAVITY = 800.0
const MAX_FALL_SPEED = 400.0

var health = 3
var direction = -1
var is_dead = false

@onready var sprite = $Sprite2D
@onready var raycast_floor = $RaycastFloor
@onready var raycast_wall = $RaycastWall

func _ready():
	add_to_group("enemies")

func _physics_process(delta):
	if is_dead:
		return
	
	# Apply gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		velocity.y = min(velocity.y, MAX_FALL_SPEED)
	
	# Check for edge or wall
	if is_on_floor():
		if not raycast_floor.is_colliding() or raycast_wall.is_colliding():
			direction *= -1
			sprite.flip_h = not sprite.flip_h
			raycast_floor.position.x *= -1
			raycast_wall.target_position.x *= -1
	
	velocity.x = direction * SPEED
	move_and_slide()
	
	# Snap to pixel-perfect grid for crisp rendering
	position = position.round()

func take_damage(amount):
	health -= amount
	# Flash effect (will be handled by animation)
	if health <= 0:
		die()

func die():
	is_dead = true
	# Play death animation and remove
	await get_tree().create_timer(0.3).timeout
	queue_free()
