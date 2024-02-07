extends CharacterBody2D


@export var SPEED : float = 200
@export var target : CharacterBody2D
const IS_RAT = true


func _ready():
	%AnimationPlayer.play("tail_wiggle")


func _physics_process(delta):
	if !target.alive:
		return

	look_at(target.position)

	velocity = Vector2(1, 0).rotated(rotation) * SPEED
	
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		var collider = collision.get_collider()
		if "IS_BOY" in collider:
			collider.blow_up()
