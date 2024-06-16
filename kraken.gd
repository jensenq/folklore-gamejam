extends CharacterBody3D

signal hit
@export var speed = 14
var target_velocity = Vector3.ZERO

func detect_collision():
	
	# Iterate through all collisions that occurred this frame
	for index in range(get_slide_collision_count()):
		# We get one of the collisions with the player
		var collision = get_slide_collision(index)

		# If the collision is with ground
		if collision.get_collider() == null:
			continue

		# If the collider is with a mob
		if collision.get_collider().is_in_group("ship"):
			var ship = collision.get_collider()
			#print("ship and kraken collided")


func _physics_process(delta):
	
	detect_collision()
	
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

func die():
	hit.emit()
	queue_free()

func _on_hit_detector_body_entered(body):
	die()
	print("ship hit")
