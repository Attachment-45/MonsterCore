extends CollisionShape2D

var i_am_colliding = false

func _ready():
	pass

func _process(delta):
	var areas = get_parent().get_overlapping_areas()
	for i in range(0, areas.size()):
		i_am_colliding = false
