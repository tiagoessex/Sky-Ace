extends Area2D

#const DELTA_TIME = 0.1
const ROTATION_SPEED = 200
const MOVE_SPEED = 300
const MAX_UPPER_ANGLE = 30
const MAX_LOWER_ANGLE = -30
#const MIN_SWIPE = 15
const MAX_Y = 450
const MIN_Y = 30

const SPEED_FALLING = Vector2(100,100)
const SPEED_SUPER_FALLING = Vector2(-150,150)
var bFalling = false
var bSuperFalling = false

var target_angle = 0
var bRotate = false

onready var tween = get_node("Tween")
onready var sprite = self


var property = "transform/rot"

var explosion = preload("res://scenes/exp1.tscn")

var max_x

func _ready():
	set_process(true)
	set_process_input(true)
	get_node("AnimatedSprite").play()
	sound(true)
	max_x = get_viewport().get_rect().size.x
	

func _process(delta):

	if bFalling or bSuperFalling:
		if bFalling:
			set_pos(get_pos() + SPEED_FALLING * delta)
			if get_rot() > -0.8:
				set_rot(get_rot() - (20 * delta) * PI / 180)
		if bSuperFalling:
				set_pos(get_pos() + SPEED_SUPER_FALLING * delta)
				if get_rot() > -1.0:
					set_rot(get_rot() - (50 * delta) * PI / 180)
				
		if (get_pos().y > 1000):
			sound(false)
			queue_free()
		
		return
	
	if Input.is_action_pressed("pointer_drag"):		
		if get_viewport().get_mouse_pos().y < 64 and get_viewport().get_mouse_pos().x > max_x - 200:
			pass
		else: 
			var v  = get_viewport().get_mouse_pos() - get_pos()
			if (abs(v.y) > 15):#MIN_SWIPE):
				if v.y < 0:
					target_angle = MAX_UPPER_ANGLE
				elif v.y > 0:
					target_angle = MAX_LOWER_ANGLE
				bRotate = true
			else:
				target_angle = 0
				bRotate = false

	if get_pos().y < MIN_Y:
		target_angle = 0
		bRotate = false
		set_pos(Vector2(get_pos().x, MIN_Y))
	if get_pos().y > MAX_Y:
		target_angle = 0
		bRotate = false
		set_pos(Vector2(get_pos().x, MAX_Y))
	
	rotate_sprite()
	if bRotate:
		if target_angle < 0:
			set_pos(Vector2(get_pos().x, get_pos().y + MOVE_SPEED * delta))
		elif target_angle > 0:
			set_pos(Vector2(get_pos().x, get_pos().y - MOVE_SPEED * delta))


func rotate_sprite():
	var start = sprite.get_rot() * 180 / PI
	var end = target_angle
	var distance = abs(start - end)
	var time = distance / ROTATION_SPEED
	
	if time <= 0: return

	if tween.is_active(): tween.stop(sprite, property)
	tween.interpolate_property(sprite, property, start, end, time, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()


func _input(event):
	if event.is_action_released("pointer_drag"):
		target_angle = 0		
		bRotate = false



func _on_player_area_enter( area ):
	#if bFalling or bSuperFalling:
	#	return
	get_node("AnimatedSprite").stop()
	get_node("AnimatedSprite").hide()
	if area.has_method("isBuilding"):
		bSuperFalling = true		
		Explosion()
	elif area.has_method("isRocket"):
		bFalling = true		
		Explosion()
	elif area.has_method("isBlimp"):
		bFalling = true
		Explosion()
	elif area.has_method("isChopper"):
		bFalling = true
		Explosion()
	elif area.has_method("isAntenna"):
		bSuperFalling = true
		Explosion()

	if not get_node("Particles2D").is_emitting():
		get_node("Particles2D").set_emitting(true)
		get_node("SamplePlayer2D").stop_all()
		sound(true)
		#get_node("SamplePlayer2D").play("falling")


	get_node("..").gameOver()



func Explosion():
	var explosion_instance
	explosion_instance = explosion.instance()
	explosion_instance.set_pos(get_pos())
	explosion_instance.set_scale(Vector2(0.75,0.75))
	get_node("..").add_child(explosion_instance)
	explosion_instance = null
	get_node("/root/sfx").PlaySound("explosion_player")

	

func isPlayer():
	return true

func isFalling():
	return (bFalling or bSuperFalling)

func sound(what = true):
#	if what:
#		if get_node("/root/global").sound:
#			if bFalling or bSuperFalling:
#				get_node("SamplePlayer2D").play("falling")
#			else:
#				get_node("SamplePlayer2D").play("player")
#	else:
#		get_node("SamplePlayer2D").stop_all()

	if what and get_node("/root/global").sound and not get_tree().is_paused():
		if bFalling or bSuperFalling:
			get_node("SamplePlayer2D").play("falling")
		else:
			get_node("SamplePlayer2D").play("player")
	else:
		get_node("SamplePlayer2D").stop_all()