extends Area2D

const SPEED = Vector2(-150,0)

var explosion = preload("res://scenes/exp1.tscn")

func _ready():
	set_process(true)
	if int(rand_range(0,2)) == 0:
		get_node("Sprite").set_flip_h(true)

func _process(delta):
	set_pos(get_pos() + SPEED * delta)
	
	if get_pos().x < -32:
		queue_free()


func isAntenna():
	return true

func _on_antena1_area_enter( area ):
	if area.has_method("isPlayer"):
		#if area.isFalling():
		#	return

		var explosion_instance
		explosion_instance = explosion.instance()
		explosion_instance.set_pos(get_pos())
		get_node("..").add_child(explosion_instance)
		explosion_instance = null
		
		get_node("/root/sfx").PlaySound("explosion_rocket")
				
		queue_free()
