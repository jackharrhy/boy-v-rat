extends CharacterBody2D


@export var SPEED : float = 1000


func _process(delta):
	velocity = Vector2(1, 0).rotated(rotation) * SPEED
	
	var collision = move_and_collide(velocity * delta)
	if collision:
		var collider = collision.get_collider()
		if "IS_RAT" in collider:
			collider.queue_free()
			queue_free()
