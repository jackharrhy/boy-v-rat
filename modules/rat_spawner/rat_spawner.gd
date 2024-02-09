extends Node2D


@export var spawn_range : int = 1000
@export var target : CharacterBody2D


func _on_timer_timeout():
	if !target.alive:
		return

	var x = randf_range(-1 * spawn_range, spawn_range)
	var y = randf_range(-1 * spawn_range, spawn_range)

	var scene = preload("res://modules/rat/rat.tscn")
	var instance = scene.instantiate()

	instance.position = Vector2(x, y)
	instance.target = target
	
	add_child(instance)
