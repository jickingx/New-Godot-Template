extends Node2D

export var restart_delay = .4


func _ready():
	bind_player_events()


func bind_player_events():
	for player in Global.current_scene.get_tree().get_nodes_in_group("players"):
		player.connect("died", self, "_on_Player_died")
		player.connect("coin_picked", self, "_on_Player_coin_picked")


func _on_Player_died():
	yield(get_tree().create_timer(restart_delay), "timeout")
	Global.restart_scene()


func _on_Player_coin_picked():
	$Label.text = "1"
