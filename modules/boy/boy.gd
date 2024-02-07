extends CharacterBody2D


@export var root_node : Node2D
const SPEED : float = 300.0
var target_angle : float
var alive : bool = true
const IS_BOY = true


func _ready():
	%AnimationPlayer.play("tail_wiggle")


func blow_up():
	alive = false


func _physics_process(_delta):
	if !alive:
		return

	var x_direction = Input.get_axis("left", "right")

	if x_direction:
		velocity.x = x_direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	var y_direction = Input.get_axis("up", "down")

	if y_direction:
		velocity.y = y_direction * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	if velocity.length() > 0:
		target_angle = velocity.angle()

	rotation = lerp_angle(
		rotation,
		target_angle,
		0.1
	)

	move_and_slide()


func _on_timer_timeout():
	if !alive:
		return

	var scene = preload("res://modules/projectile/projectile.tscn")
	var instance = scene.instantiate()
	instance.position = position
	instance.rotation = rotation

	root_node.add_child(instance)
