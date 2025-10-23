extends Area2D

const SPEED = 200.0
var direction = 1

func _ready():
	body_entered.connect(_on_body_entered)
	area_entered.connect(_on_area_entered)

func _physics_process(delta):
	position.x += direction * SPEED * delta
	# Snap to pixel-perfect grid for crisp rendering
	position = position.round()

func _on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(1)
	queue_free()

func _on_area_entered(area):
	if area.is_in_group("enemies"):
		if area.has_method("take_damage"):
			area.take_damage(1)
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
