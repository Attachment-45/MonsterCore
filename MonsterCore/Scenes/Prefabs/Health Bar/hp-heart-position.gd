extends Sprite

func _ready():
	position.x = get_parent().pos_x + 26
	position.y = get_parent().pos_y + 23

func _process(delta):
	position.x = get_parent().pos_x + 26
	position.y = get_parent().pos_y + 23
