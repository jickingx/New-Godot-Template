class_name Pickup
extends StaticBody2D

signal picked
const GROUP = "pickups"


func _ready():
	if not self.is_in_group(GROUP):
		self.add_to_group(GROUP)


func pick():
	$CollisionShape2D.queue_free()
	emit_signal("picked")
	$AnimationPlayer.play("picked")
	yield($AnimationPlayer, "animation_finished")
	queue_free()
