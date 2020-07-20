class_name Actor
extends KinematicBody2D

signal die
const ParticlesExplosion = preload("res://src/FX/Particles/Explosion.tscn")
export var gravity := 640 * 2  # px / s ^2
export var speed_max := 256 # px / s
var is_dead := false
var velocity = Vector2.ZERO


func die():
	emit_signal("die")
	is_dead = true
	add_explosion()
	$AnimationPlayer.play("hurt")
	$Sounds/Hurt.play()
	yield($Sounds/Hurt, "finished")
	queue_free()


func add_explosion():
	var ex = ParticlesExplosion.instance()
	ex.position = self.position
	Global.current_scene.add_child(ex)
	ex.emitting = true
