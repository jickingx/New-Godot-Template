extends Actor

export var friction := 16
export var acceleration := 16
export var jump_height := 128 # px
var jump_velocity := sqrt(2 * gravity * jump_height) # px / s
var direction_x := 0


func _process(delta):
	direction_x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")


func _physics_process(delta):
	if is_dead :
		return
	velocity.y += gravity * delta
	if direction_x != 0:
		velocity.x += direction_x * acceleration * delta * Global.FPS
		velocity.x = clamp(velocity.x, -speed_max, speed_max)

	if is_on_floor():
		if direction_x == 0:
			velocity.x = lerp(velocity.x, 0, friction * delta)
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = -jump_velocity
			$Sounds/Jump.play()
	else:
		if direction_x == 0:
			velocity.x = lerp(velocity.x, 0, friction / 4 * delta)
		if Input.is_action_just_released("ui_up") and velocity.y < -jump_velocity / 2:
			velocity.y = -jump_velocity / 2

	velocity = move_and_slide(velocity, Vector2.UP)


func _on_Detector_body_entered(body):
	if body.is_in_group("hazards"):
		die()
