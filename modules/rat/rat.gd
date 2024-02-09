extends RigidBody2D


@export var SPEED : float = 200
@export var target : CharacterBody2D
var chasing : bool = false


func _ready():
	%BodySprite.scale = Vector2(0, 0)
	%AnimationPlayer.play("fade_in")
	look_at(target.position)


func _physics_process(delta):
	if !target.alive:
		return

	look_at(target.position)
	
	if !chasing:
		return

	var velocity = Vector2(1, 0).rotated(rotation) * SPEED

	var collision = move_and_collide(velocity * delta)

	if collision:
		var collider = collision.get_collider()
		if collider.is_in_group("boy"):
			collider.blow_up()


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fade_in":
		chasing = true
		%CollisionPolygon2D.disabled = false
		%AnimationPlayer.play("tail_wiggle")
