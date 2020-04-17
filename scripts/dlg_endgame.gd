extends TextureFrame

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_TextureButton_no_button_down():
	get_node("/root/sfx").PlaySound("click")
	set_hidden(true)
	get_node("../TextureButton2_pause").set_pause_mode(2)
	if get_node("../Label_pause").is_visible():
		return
	get_tree().set_pause(false)
	get_node("../TextureButton2_pause").set_pressed(false)
	get_node("../..").actOnSounds()


func _on_TextureButton_yes_button_down():
	get_node("/root/sfx").PlaySound("click")
	get_tree().set_pause(false)
	get_node("/root/global").save_shits()
	get_node("/root/global").goto_scene("res://scenes/mainmenu.tscn")



