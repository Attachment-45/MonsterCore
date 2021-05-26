extends Sprite

#global variables
export var health = 100

func health_correction():
	#correction
	health = float(health)
	health /= 100
	
	#display
	scale.x = health

func _ready():
	#hp
	health_correction()
