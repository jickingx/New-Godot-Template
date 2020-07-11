extends CanvasLayer

export(String, FILE) var next_scene
export(float) var scene_switch_delay := .6

var is_scene_switching:= false

func _on_Button_button_up():
	if is_scene_switching:
		return
	
	is_scene_switching = true
	$AudioStreamPlayer.play()
	yield(get_tree().create_timer(scene_switch_delay), "timeout")
	Global.switch_scene(next_scene)
