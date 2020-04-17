extends Node


onready var gl = get_node("/root/global")
onready var gui_score = get_node("stage_gui/Label_score")
onready var gui_hiscore = get_node("stage_gui/Label_hi")
onready var rockets_gen = get_node("rockets_generator")
onready var blimps_gen = get_node("blimps_generator")
onready var choppers_gen = get_node("choppers_generator")
onready var buildings_gen = get_node("buildings_generator")
onready var player = get_node("player")

func _ready():	
	updateHiScore()
	
	gl.reset()
	
	if gl.bFirstTime:
		gl.bFirstTime = false
		get_node("stage_gui/Label_help").show()
		get_node("stage_gui/AnimationPlayer").play("New Anim")


func updateScore(qt):
	gl.score += qt
	var str_score = str(("%08d" % [gl.score]))
	gui_score.set_text(str(str_score))
	if gl.newHigh():
		gl.highscore = gl.score
		updateHiScore()
	if gl.score % 10 == 0:
		manageLevel()


func updateHiScore():
	var str_score = str(("%08d" % [gl.highscore]))
	gui_hiscore.set_text("Hi: " + str(str_score))


func _on_Timer_timeout():
	updateScore(1)

func gameOver():
	gl.gameover = true
	gl.save_shits()
	get_node("Timer").stop()
	get_node("Timer_gameover").start()	
	rockets_gen.stop()
	blimps_gen.stop()

	

func _on_Timer_gameover_timeout():
	get_node("stage_gui/gameover").show()	
	get_node("/root/sfx").StopAll()
	get_node("/root/sfx").PlaySound("gameover")


func doSounds(what):
	var blimps = blimps_gen.get_children()
	var rockets = rockets_gen.get_children()

	for a in blimps:
		if a.has_method("isBlimp"):
			get_node("/root/sfx").PlaySound("blimp")

	for a in rockets:
		if a.has_method("isRocket"):
			get_node("/root/sfx").PlaySound("rocket")
	

func actOnSounds(sound = true):
	var blimps = blimps_gen.get_children()
	var rockets = rockets_gen.get_children()
	var choppers = choppers_gen.get_children()

	var s = get_node("/root/global").sound
	
	for b in blimps:
		if b.has_method("isBlimp"):
			#b.sound(s and !get_tree().is_paused())
			b.sound(sound)
	
	for r in rockets:
		if r.has_method("isRocket"):
			#r.sound(s and !get_tree().is_paused())
			r.sound(sound)

	for c in choppers:
		if c.has_method("isChopper"):
			#c.sound(s and !get_tree().is_paused())
			c.sound(sound)

	if player:
		#player.sound(s and !get_tree().is_paused())
		player.sound(sound)



func manageLevel():
	if int(rand_range(0,2)) == 0:
		buildings_gen.incDifficulty(0.15)
	if int(rand_range(0,2)) == 0:
		rockets_gen.incDifficulty(0.15)
	if int(rand_range(0,2)) == 0:
		blimps_gen.incDifficulty(0.15)
	if int(rand_range(0,2)) == 0:
		choppers_gen.incDifficulty(0.15)