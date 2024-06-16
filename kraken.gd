extends CharacterBody3D

# How fast the player moves in meters per second.
@export var speed = 14

var target_velocity = Vector3.ZERO


func _physics_process(delta):
	var direction = Vector3.ZERO

	if Input.is_action_pressed("p1_right"):
		direction.x += 1
	if Input.is_action_pressed("p1_left"):
		direction.x -= 1
	if Input.is_action_pressed("p1_back"):
		direction.z += 1
	if Input.is_action_pressed("p1_forward"):
		direction.z -= 1

	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$pivot.basis = Basis.looking_at(direction)

	# Ground Velocity
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed

	# Moving the Character
	velocity = target_velocity
	move_and_slide()
