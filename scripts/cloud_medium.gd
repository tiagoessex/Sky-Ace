extends Sprite

const SPEED = Vector2(-100,0)


func _ready():
	set_process(true)


func _process(delta):
	set_pos(get_pos() + SPEED * delta)
	
	if get_pos().x < -48:
		queue_free()