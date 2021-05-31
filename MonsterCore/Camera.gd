extends Camera2D

var offsetX = 0
var offsetY = 0

func screen_shake(scale):
	var dir_range = RandomNumberGenerator.new()
	dir_range.randomize()
	var dir = dir_range.randi_range(0, 1)
	if dir == 0:
		dir -= 1
	return dir * scale

func _ready():
	position.x = 0
	position.y = 0

func _process(delta):
	pass
