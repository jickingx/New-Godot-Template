extends CanvasLayer


func _ready():
	pass


func fade_in():
	$AnimationPlayer.play("fade")


func fade_out():
	$AnimationPlayer.play_backwards("fade")
