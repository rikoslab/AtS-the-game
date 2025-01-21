extends CharacterBody2D

var direction = Vector2.ZERO
var Accel = 500
var Speed = 800
var Frict = 700

func _process(delta):
	direction.x = Input.get_axis("Left", "Right")
	direction.y = Input.get_axis("Up", "Down")
	direction = direction.normalized()

	if direction != Vector2.ZERO:
		velocity = velocity.move_toward(direction * Speed, Accel * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, Frict * delta)

	move_and_slide()
