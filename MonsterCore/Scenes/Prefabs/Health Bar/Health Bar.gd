extends Node

export var pos_x = 0
export var pos_y = 0
export var off_x = 0
export var off_y = 0

func _ready():
	pass

func _process(delta):
	pos_x = get_parent().position.x + off_x
	pos_y = get_parent().position.y + off_y
