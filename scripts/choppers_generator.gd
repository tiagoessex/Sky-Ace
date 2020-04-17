extends Node

const PROB_CHOPPER = 2


var chopper = preload("res://scenes/chopper.tscn")
var x


func _ready():
	randomize()
	x = get_viewport().get_rect().size.x + 96


func _on_Timer_timeout():
	if int(rand_range(0,PROB_CHOPPER)) >= 1:
		return

	var y = int(rand_range(15,360))
	createChopper(Vector2(x,y))


func createChopper(where):
	var chopper_instance
	chopper_instance = chopper.instance()
	chopper_instance.set_pos(where)	
	add_child(chopper_instance)
	chopper_instance = null
	
func stop():
	get_node("Timer").stop()
	

func incDifficulty(qt):
	var node = get_node("Timer")
	if node.get_wait_time() <= 2:
		return
	else:
		node.set_wait_time(node.get_wait_time() - qt)
	
	
	
	
	
