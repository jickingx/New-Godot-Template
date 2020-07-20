extends Node2D

export var restart_delay = .4


func _on_Player_die():
	yield(get_tree().create_timer(restart_delay), "timeout")
	Global.restart_scene()
