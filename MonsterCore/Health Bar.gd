extends Node

export var pos_x = 0
export var pos_y = 0
export var off_x = 0
export var off_y = 0
var health_amt = 100

func _ready():
	pass

func _process(delta):
	# positions
	pos_x = get_parent().get_node("Player").position.x + off_x
	pos_y = get_parent().get_node("Player").position.y + off_y
	
	# health
	health_amt = get_parent().get_node("Player").hp
