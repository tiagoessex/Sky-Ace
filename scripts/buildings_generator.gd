extends Node

const PROB_BUILDING = 2
const PROB_ANTENNA = 4

var building = preload("res://scenes/building1.tscn")
var antena1 = preload("res://scenes/antena1.tscn")
var antena2 = preload("res://scenes/antena2.tscn")
var x

onready var buildings = get_node("..")

func _ready():
	randomize()
	x = get_viewport().get_rect().size.x + 128


func _on_Timer_timeout():
	if int(rand_range(0,PROB_BUILDING)) >= 1:
		return
	var y = int(rand_range(500,580))
	var building_instance
	building_instance = building.instance()
	building_instance.set_pos(Vector2(x, y))	
	add_child(building_instance)
	building_instance = null
	
	var antena = int(rand_range(0,PROB_ANTENNA))
	if antena == 0:
		var antena_instance
		antena_instance = antena1.instance()
		antena_instance.set_pos(Vector2(int(rand_range(x - 100, x + 100)), y - 128 - 32 + 5))
		add_child(antena_instance)
		antena_instance = null
	elif antena == 1:
		var antena_instance
		antena_instance = antena2.instance()
		antena_instance.set_pos(Vector2(int(rand_range(x - 100, x + 100)), y - 128 - 32 + 5))
		add_child(antena_instance)
		antena_instance = null


func incDifficulty(qt):
	var node = get_node("Timer")
	if node.get_wait_time() <= 1.6:
		return
	else:
		node.set_wait_time(node.get_wait_time() - qt)

	
	
