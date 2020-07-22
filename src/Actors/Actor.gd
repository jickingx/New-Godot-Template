class_name Actor
extends KinematicBody2D

signal died
const ParticlesExplosion = preload("res://src/FX/Particles/Explosion.tscn")
export var gravity := 640 * 2  # px / s ^2
export var speed_max := 256 # px / s
var is_dead := false
var velocity = Vector2.ZERO


func die():
	is_dead = true
	emit_signal("died")
	collisions_deffered()
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


func collisions_deffered():
	if is_instance_valid($CollisionShape2D):
		$CollisionShape2D.queue_free()
	if is_instance_valid($Detector):
		$Detector.queue_free()
