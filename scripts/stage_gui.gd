extends CanvasLayer


func _ready():
	if get_node("/root/global").sound:
		get_node("TextureButton1_sound").set_pressed(false)
	else:
		get_node("TextureButton1_sound").set_pressed(true)
	


func _on_TextureButton2_pause_button_down():
	get_node("/root/sfx").PlaySound("click")
	if get_node("/root/global").gameover:
		get_node("..").actOnSounds(false)
		return
	get_node("Label_pause").set_hidden(not get_node("Label_pause").is_hidden())
	get_tree().set_pause(!get_tree().is_paused())
	get_node("..").actOnSounds(!get_tree().is_paused())


func _on_TextureButton_menu_button_down():
	get_node("/root/sfx").PlaySound("click")
	if get_node("/root/global").gameover:
		return
	if get_node("dlg_endgame").is_visible():
		get_node("dlg_endgame").hide()		
		get_node("TextureButton2_pause").set_pause_mode(2)
		get_node("/root/sfx").PlaySound("dialog_close")		
		if get_node("Label_pause").is_visible():
			get_node("..").actOnSounds(false)
			return
		get_tree().set_pause(false)
		get_node("TextureButton2_pause").set_pressed(false)
		get_node("..").actOnSounds(true)
	else:
		get_node("/root/sfx").PlaySound("dlg_open")
		get_node("dlg_endgame").show()
		get_tree().set_pause(true)
		get_node("TextureButton2_pause").set_pressed(true)
		get_node("TextureButton2_pause").set_pause_mode(0)
		get_node("..").actOnSounds(false)

func _on_TextureButton1_sound_button_down():
	get_node("/root/sfx").PlaySound("click")
	get_node("/root/global").sound = !get_node("/root/global").sound 
	get_node("..").actOnSounds(get_node("/root/global").sound)
	if not get_node("/root/global").sound:
		get_node("/root/sfx").StopAll()
	#else:
	#	get_node("..").doSounds(false)