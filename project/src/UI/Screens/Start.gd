extends CanvasLayer

export(String, FILE) var next_scene
export(float) var scene_switch_delay := .6


func _on_Button_button_up():
	$MarginContainer/VBoxContainer/CenterContainer/Button.disabled = true
	$AudioStreamPlayer.play()
	yield(get_tree().create_timer(scene_switch_delay), "timeout")
	Global.switch_scene(next_scene)
