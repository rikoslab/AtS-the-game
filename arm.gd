extends Area2D

@onready var label: Label = $Label
@onready var arm: Sprite2D = $Sprite2D
@export var mob : CharacterBody2D
@export var player: CharacterBody2D
@export var max_speed: float = 20.0
@export var Damage_trhhold: float = 18.0
@export var Damage = 1
@export var Stamina = 200 

var Accel = 8.0
var Frict = 12.0
var speed : float = 50.0
var spin_direct: float = 1.0
var prev_mouse_position = Vector2.ZERO
var cur_speed : float = 0.0

func playerActInput(delta):
	if Input.is_action_pressed("Action"):
		arm.visible = true
		#position from global mouse position
		var mouse_position = get_global_mouse_position()
	#direction to mouse position by player
		var direction = (mouse_position - player.global_position).normalized()
	#arm rotating to mouse by current speed to max speed
		var mouse_movement: Vector2 = mouse_position - prev_mouse_position
		var mouse_speed: float = mouse_movement.length() / delta
		#cur_speed = mouse_movement.length() / delta
		#cur_speed = min(cur_speed, max_speed)
		if direction.x != 0:
			spin_direct = sign(direction.x)
		
		prev_mouse_position = mouse_position - prev_mouse_position
		if mouse_speed > 0:
			cur_speed = min(cur_speed + Accel * delta, max_speed)
	else:
		cur_speed = max(cur_speed - Frict * delta, 0)
	rotation += cur_speed * spin_direct * delta

func _process(delta):
	
	global_position = player.global_position
	playerActInput(delta)

func _on_body_entered(mob):
	if mob.has_method("take_damage") and cur_speed >= Damage_trhhold:
		mob.take_damage(Damage)
