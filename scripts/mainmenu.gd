extends CanvasLayer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	if get_node("/root/global").sound:
		get_node("TextureButton_sound").set_pressed(false)
	else:
		get_node("TextureButton_sound").set_pressed(true)
	
	if get_node("/root/global").sound:
		get_node("plane/SamplePlayer2D").play("player")		
	else:
		get_node("plane/SamplePlayer2D").stop_all()

	if int(rand_range(0,2)) == 0:
		get_node("/root/global").show_interstitial()


func _on_TextureButton_exit_button_down():
	get_node("/root/sfx").PlaySound("click")
	get_node("/root/sfx").PlaySound("dlg_open")
	get_node("dlg_exitgame").show()
	


func _on_TextureButton_play_button_down():
	get_node("/root/sfx").PlaySound("click")
	get_node("/root/global").goto_scene("res://scenes/game_src.tscn")


func _on_TextureButton_sound_button_down():
	get_node("/root/sfx").PlaySound("click")
	get_node("/root/global").sound = !get_node("/root/global").sound 

	if get_node("/root/global").sound:
		get_node("plane/SamplePlayer2D").play("player")
	else:
		get_node("plane/SamplePlayer2D").stop_all()