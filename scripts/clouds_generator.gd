extends Node

var big = preload("res://scenes/cloud_big.tscn")
var medium = preload("res://scenes/cloud_medium.tscn")
var small = preload("res://scenes/cloud_small.tscn")
var x = 0

#onready var clouds = get_node("..")

func _ready():
	randomize()
	x = get_viewport().get_rect().size.x


func _on_Timer_timeout():
	var type = int(rand_range(0,3))
	var cloud_instance
	if type == 0:
		cloud_instance = big.instance()
		x += 32
	elif type == 1:
		cloud_instance = medium.instance()
		x += 24
	else:
		cloud_instance = small.instance()
		x += 16
	cloud_instance.set_pos(Vector2(x, int(rand_range(0,330))))
	#clouds.add_child(cloud_instance)
	if int(rand_range(0,2)) == 0:
		cloud_instance.set_flip_h(true)
	add_child(cloud_instance)
	cloud_instance = null
