extends CharacterBody2D

# Player constants
const SPEED = 100.0
const JUMP_VELOCITY = -300.0
const GRAVITY = 800.0
const MAX_FALL_SPEED = 400.0
const WALL_SLIDE_SPEED = 50.0

# Shooting
const SHOOT_COOLDOWN = 0.3
var can_shoot = true
var shoot_timer = 0.0

# References
@onready var sprite = $Sprite2D
@onready var animation_player = $AnimationPlayer
@onready var bullet_scene = preload("res://scenes/bullet.tscn")
@onready var shoot_point = $ShootPoint

# State
var facing_right = true
var is_wall_sliding = false

func _ready():
	pass

func _physics_process(delta):
	# Handle shooting cooldown
	if not can_shoot:
		shoot_timer += delta
		if shoot_timer >= SHOOT_COOLDOWN:
			can_shoot = true
			shoot_timer = 0.0
	
	# Apply gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		velocity.y = min(velocity.y, MAX_FALL_SPEED)
	
	# Check for wall sliding
	is_wall_sliding = false
	if not is_on_floor() and is_on_wall() and velocity.y > 0:
		is_wall_sliding = true
		velocity.y = WALL_SLIDE_SPEED
	
	# Handle jump
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
		elif is_wall_sliding:
			# Wall jump
			velocity.y = JUMP_VELOCITY
			velocity.x = SPEED if get_wall_normal().x > 0 else -SPEED
	
	# Handle movement
	var direction = Input.get_axis("move_left", "move_right")
	if direction != 0:
		velocity.x = direction * SPEED
		# Update facing direction
		if direction > 0 and not facing_right:
			facing_right = true
			sprite.flip_h = false
			shoot_point.position.x = abs(shoot_point.position.x)
		elif direction < 0 and facing_right:
			facing_right = false
			sprite.flip_h = true
			shoot_point.position.x = -abs(shoot_point.position.x)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# Handle shooting
	if Input.is_action_just_pressed("shoot") and can_shoot:
		shoot()
	
	move_and_slide()
	
	# Snap to pixel-perfect grid for crisp rendering
	position = position.round()
	
	# Update animation
	update_animation()

func shoot():
	if not can_shoot:
		return
	
	can_shoot = false
	var bullet = bullet_scene.instantiate()
	get_parent().add_child(bullet)
	bullet.global_position = shoot_point.global_position
	bullet.direction = 1 if facing_right else -1

func update_animation():
	if is_on_floor():
		if abs(velocity.x) > 0:
			animation_player.play("run")
		else:
			animation_player.play("idle")
	else:
		if is_wall_sliding:
			animation_player.play("wall_slide")
		elif velocity.y < 0:
			animation_player.play("jump")
		else:
			animation_player.play("fall")
