extends TextureFrame



func _on_TextureButton_no_button_down():
	get_node("/root/sfx").PlaySound("click")
	get_node("/root/sfx").PlaySound("dialog_close")
	set_hidden(true)


func _on_TextureButton_yes_button_down():
	get_node("/root/sfx").PlaySound("click")
	get_tree().quit()
