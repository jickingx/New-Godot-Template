class_name Actor
extends KinematicBody2D

signal died
const ParticlesExplosion = preload("res://src/FX/Particles/Explosion.tscn")
export var gravity := 640 * 2  # px / s ^2
export var speed_max := 256 # px / s
var is_disabled_movement := false
var velocity = Vector2.ZERO


func _physics_process(delta):
	if is_disabled_movement :
		return
	velocity.y += gravity * delta


func die():
	is_disabled_movement = true
	remove_collisions()
	add_explosion()
	$AnimationPlayer.play("hurt")
	$Sounds/Hurt.play()
	yield($Sounds/Hurt, "finished")
	emit_signal("died")
	#handle death on died signal observer


func add_explosion():
	var ex = ParticlesExplosion.instance()
	ex.position = self.position
	Global.current_scene.add_child(ex)
	ex.emitting = true


func remove_collisions():
	if is_instance_valid($CollisionShape2D):
		$CollisionShape2D.queue_free()
	if is_instance_valid($Detector):
		$Detector.queue_free()
