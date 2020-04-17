extends TextureFrame



func _on_Timer_timeout():
	get_node("/root/global").goto_scene("res://scenes/mainmenu.tscn")



func _on_gameover_visibility_changed():
	if not get_node("Timer").is_processing():
		get_node("Timer").start()
		get_node("AnimationPlayer").play("gameover")
		
