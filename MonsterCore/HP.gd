extends Sprite

# global variables
var health = 100

func health_correction():
	# correction
	health = float(health)
	health /= 100
	
	# display
	scale.x = health

func _ready():
	# get data
	health = get_parent().get_parent().health_amt
	
	# hp
	health_correction()

func _process(delta):
	# get data
	health = get_parent().get_parent().health_amt
	
	# hp
	health_correction()
