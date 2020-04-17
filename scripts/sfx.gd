extends SamplePlayer

func StopAll():
	stop_all()


func PlaySound(which):
	
	if not get_node("/root/global").sound:
		return
	#print ("sound > ", which)
	if which == "click":
		play("click")
	elif which == "dialog_close":
		play("dialog_close")
	elif which == "dlg_open":
		play("dlg_open")
	elif which == "explosion_blimp":
		play("explosion_blimp")
	elif which == "explosion_player":
		play("explosion_player")
	elif which == "explosion_rocket":
		play("explosion_rocket")
	elif which == "gameover":
		play("gameover")
	elif which == "pickup":
		play("pickup")
	#elif which == "blimp":
	#	play("blimp")
	#elif which == "rocket":
	#	play("rocket")
	else:
		print ("FUCK")