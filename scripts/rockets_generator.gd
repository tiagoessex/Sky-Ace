extends Node

const PROB_ROCKET = 3


var rocket = preload("res://scenes/rocket.tscn")
var x


func _ready():
	randomize()
	x = get_viewport().get_rect().size.x + 32


func _on_Timer_timeout():
	if int(rand_range(0,PROB_ROCKET)) >= 1:
		return

	var y = int(rand_range(10,360))
	createRocket(Vector2(x, y))


func createRocket(where):
	var rocket_instance
	rocket_instance = rocket.instance()
	rocket_instance.set_pos(where)	
	add_child(rocket_instance)
	rocket_instance = null
	
func stop():
	get_node("Timer").stop()
	

func incDifficulty(qt):
	var node = get_node("Timer")
	if node.get_wait_time() <= 0.5:
		return
	else:
		node.set_wait_time(node.get_wait_time() - qt)
	
	
	
	
	
