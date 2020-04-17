extends Area2D


const SPEED = Vector2(-150,0)
const SPEED_FALLING = Vector2(-100,50)
const SPEED_VAR = Vector2(25,0)

#var explosion = preload("res://scenes/explosion2.tscn")
var bFalling = false
var speed

func _ready():
	set_process(true)
	#get_node("/root/sfx").PlaySound("blimp")
	sound(true)
	var v_x = int(rand_range(SPEED.x - SPEED_VAR.x,SPEED.x + SPEED_VAR.x))
	var v_y = int(rand_range(SPEED.y - SPEED_VAR.y,SPEED.y + SPEED_VAR.y))
	speed = Vector2(v_x, v_y) 


func _process(delta):
	if not bFalling:
		set_pos(get_pos() + speed * delta)
	else:
		set_pos(get_pos() + SPEED_FALLING * delta)		
		if get_rot() < 0.8:
			set_rot(get_rot() + (10 * delta) * PI / 180)
		
	if get_pos().x < -200 or get_pos().y > 520:
		sound(false)
		queue_free()

func isBlimp():
	return true



func _on_blimp_area_enter( area ):
	if area.has_method("isPlayer"):
		bFalling = true
		get_node("Particles2D").set_emitting(true)
		sound(false)
		if get_node("/root/global").sound:
			get_node("SamplePlayer2D").play("explosion_blimp")
		#get_node("/root/sfx").PlaySound("explosion_blimp")
		

func sound(what = true):
	#if what:
	if what and get_node("/root/global").sound and not get_tree().is_paused():
		if not bFalling:
			get_node("SamplePlayer2D").play("blimp")
	else:
		get_node("SamplePlayer2D").stop_all()