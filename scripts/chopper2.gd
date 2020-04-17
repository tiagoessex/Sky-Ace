extends Node2D


const SPEED = Vector2(-200,0)
const SPEED_FALLING = Vector2(-100,50)
const SPEED_VAR = Vector2(100,0)


var bFalling = false
var speed

func _ready():
	set_process(true)
	sound(true)
	get_node("Area2D/AnimatedSprite").play()
	get_node("Area2D/AnimatedSprite1").play()
	get_node("Area2D/AnimationPlayer").play("New Anim")
	
	var v_x = int(rand_range(SPEED.x - SPEED_VAR.x,SPEED.x + SPEED_VAR.x))
	var v_y = int(rand_range(SPEED.y - SPEED_VAR.y,SPEED.y + SPEED_VAR.y))
	speed = Vector2(v_x, v_y) 


func _process(delta):
	if not bFalling:
		set_pos(get_pos() + speed * delta)
	else:
		set_pos(get_pos() + SPEED_FALLING * delta)		
		if get_rot() < 1.3:
			set_rot(get_rot() + (30 * delta) * PI / 180)
		
	if get_pos().x < -200 or get_pos().y > 520:
		sound(false)
		queue_free()

func isChopper():
	return true



func _on_Area2D_area_enter( area ):
	if area.has_method("isPlayer"):
		bFalling = true
		if not get_node("Area2D/Particles2D").is_emitting():			
			get_node("Area2D/Particles2D").set_emitting(true)
			get_node("Area2D/AnimatedSprite").stop()
			get_node("Area2D/AnimatedSprite1").stop()
			get_node("Area2D/AnimatedSprite").hide()#set_frame(0)
			get_node("Area2D/AnimatedSprite1").hide()#set_frame(0)
			get_node("Area2D/AnimationPlayer").stop_all()
			sound(false)
			if get_node("/root/global").sound:
				get_node("Area2D/SamplePlayer2D").play("explosion_player")


func sound(what = true):
	#if what:
	if what and get_node("/root/global").sound and not get_tree().is_paused():
		if not bFalling:
			get_node("Area2D/SamplePlayer2D").play("chopper")
	else:
		get_node("Area2D/SamplePlayer2D").stop_all()

