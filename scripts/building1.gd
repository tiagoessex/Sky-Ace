extends Area2D

const SPEED = Vector2(-150,0)

func _ready():
	set_process(true)
	if int(rand_range(0,2)) == 0:
		get_node("AnimatedSprite").set_frame(1)
	if int(rand_range(0,2)) == 0:
		get_node("AnimatedSprite").set_flip_h(true)

func _process(delta):
	set_pos(get_pos() + SPEED * delta)
	
	if get_pos().x < -128:
		queue_free()



func isBuilding():
	return true
