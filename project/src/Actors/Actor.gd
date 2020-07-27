class_name Actor
extends KinematicBody2D

signal died
export (PackedScene) var ParticlesExplosion: PackedScene
export var gravity := 640 * 2  # px / s ^2
export var speed_max := 256 # px / s
var can_move := true
var velocity = Vector2.ZERO


func _ready():
	assert(ParticlesExplosion, "'ParticlesExplosion' wasn't set")

func _physics_process(delta):
	if not can_move :
		return
	velocity.y += gravity * delta


func die():
	can_move = false
	remove_collisions()
	add_explosion()
	$AnimationPlayer.play("hurt")
	$Sounds/Hurt.play()
	yield($Sounds/Hurt, "finished")
	emit_signal("died")
	#call free() on signal observer


func add_explosion():
	var ex = ParticlesExplosion.instance()
	Global.current_scene.add_child(ex)
	ex.global_position = self.global_position
	ex.emitting = true


func remove_collisions():
	if is_instance_valid($CollisionShape2D):
		$CollisionShape2D.queue_free()
	if is_instance_valid($Detector):
		$Detector.queue_free()
