extends Node

const PROB_BLIMPS = 2


var blimp = preload("res://scenes/blimp.tscn")
var x


func _ready():
	randomize()
	x = get_viewport().get_rect().size.x + 96


func _on_Timer_timeout():
	if int(rand_range(0,PROB_BLIMPS)) >= 1:
		return

	var y = int(rand_range(15,360))
	createBlimp(Vector2(x,y))


func createBlimp(where):
	var blimp_instance
	blimp_instance = blimp.instance()
	blimp_instance.set_pos(where)	
	add_child(blimp_instance)
	blimp_instance = null
	
func stop():
	get_node("Timer").stop()


func incDifficulty(qt):
	var node = get_node("Timer")
	if node.get_wait_time() <= 3.0:
		#print ("no more diff")
		return
	else:
		node.set_wait_time(node.get_wait_time() - qt)
		#print ("more diff > ", node.get_wait_time())
	
	

	
	
	
