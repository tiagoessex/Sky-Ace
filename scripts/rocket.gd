extends Area2D

const SPEED = Vector2(-400,0)

var explosion = preload("res://scenes/exp1.tscn")

func _ready():
	set_process(true)
	sound(true)
	#get_node("/root/sfx").PlaySound("rocket")


func _process(delta):
	set_pos(get_pos() + SPEED * delta)
	
	if get_pos().x < -150:
		sound(false)
		#print ("OUT")
		queue_free()

func isRocket():
	return true

func _on_rocket_area_enter( area ):
	if area.has_method("isPlayer"):	
		
		var explosion_instance
		explosion_instance = explosion.instance()
		explosion_instance.set_pos(get_pos())
		get_node("..").add_child(explosion_instance)
		explosion_instance = null
		
		get_node("/root/sfx").PlaySound("explosion_rocket")
		
		sound(false)
		queue_free()

func sound(what = true):
	if what and get_node("/root/global").sound and not get_tree().is_paused():
		if get_node("/root/global").sound:
			get_node("SamplePlayer2D").play("rocket")
	else:
		get_node("SamplePlayer2D").stop_all()