extends CharacterBody2D

class_name Enemy

@export var health = 3

func take_damage(damage):
	health -= 1
	if health <= 0:
		die()

func die():
	queue_free()

func _process(delta: float) -> void:
	pass
