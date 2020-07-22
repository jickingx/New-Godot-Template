class_name Pickup
extends Area2D

signal picked
const GROUP = "pickups"


func _ready():
	if not self.is_in_group(GROUP):
		self.add_to_group(GROUP)


func pick():
	remove_collisions()
	emit_signal("picked")
	$AnimationPlayer.play("picked")
	yield($AnimationPlayer, "animation_finished")
	queue_free()


func remove_collisions():
	if is_instance_valid($CollisionShape2D):
		$CollisionShape2D.queue_free()
