extends Node


var current_scene = null

var score = 0
var highscore = 0
var bFirstTime = true	# if true present help at start
var gameover = false
var sound = true

var admob = null;
var admob_interstitial_id = "xxxxxxxxxxxx"


func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child( root.get_child_count() -1 )
	
	reset()
	
	load_shits()
	#print ("highscore > " + str(highscore))
	#print ("bFirstTime > " + str(bFirstTime))

	##############################################################
	############################### ADMOB ########################
	##############################################################
	

	if Globals.has_singleton("bbAdmob"):
		admob = Globals.get_singleton("bbAdmob")
		#You can call admob.init_admob_test or admob.init_admob_real
		#If the last argument is true, the banner ad will be at the top of the screen
		#Function prototype init_admob_banner_test(int instance_id, string app_banner_id, string app_interstitial_id, boolean isTop)
		#admob.init_admob_test(get_instance_ID(), admob_banner_id, admob_interstitial_id, false)
		admob.init_admob_interstitial_real(get_instance_ID(), admob_interstitial_id, true)

func show_interstitial():
	if admob != null:
		admob.show_interstitial()

func reset():
	score = 0
	gameover = false


func newHigh():
	if (score > highscore):
		return true
	else:
		return false

func save():
	if newHigh():
		highscore = score
	var savedict = {
		saved_highscore = highscore,
		saved_bFirstTime = bFirstTime
	}
	return savedict


func save_shits():
	var savegame = File.new()
	savegame.open("user://er_1.save", File.WRITE)
	var nodedata = self.save()
	savegame.store_line(nodedata.to_json())
	savegame.close()

func load_shits():
	var savegame = File.new()
	if !savegame.file_exists("user://er_1.save"):
		print ("UNABLE TO LOAD SHITS")
		return #Error!  We don't have a save to load
	else:
		print ("LOADING SHITS ...")
		savegame.open("user://er_1.save", File.READ)
		var saved_data = {} # dict.parse_json() requires a declared dict.
		saved_data.parse_json(savegame.get_line())
		savegame.close()
		highscore = saved_data["saved_highscore"]
		bFirstTime = saved_data["saved_bFirstTime"]




##################################
# SCENE LOGIC
##################################
func goto_scene(path):
	call_deferred("_deferred_goto_scene",path)


func _deferred_goto_scene(path):
	current_scene.free()
	var s = ResourceLoader.load(path)
	current_scene = s.instance()
	get_tree().get_root().add_child(current_scene)
	get_tree().set_current_scene( current_scene )

