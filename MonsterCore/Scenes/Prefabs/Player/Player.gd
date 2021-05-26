extends Area2D

#public variables
export var speed = 400
export var move_type = "IDLE"
export var direction_sense = "FRONT"
export var start_x = 0
export var start_y = 0

export var env_x = 0
export var env_y = 0

#variables
var screen_size

#executions on load
func _ready():
	position.x = start_x
	position.y = start_y
	screen_size = get_viewport_rect().size

#updating executions
func _process(delta):
	var last_key = ""
	
	var vel = Vector2()
	
	#input
	if Input.is_action_pressed("ui_right"):
		vel.x += 1
		env_x -= speed
		last_key = "right"
	if Input.is_action_pressed("ui_left"):
		vel.x -= 1
		env_x += speed
		last_key = "left"
	if Input.is_action_pressed("ui_up"):
		vel.y -= 1
		env_y += speed
		last_key = "up"
	if Input.is_action_pressed("ui_down"):
		vel.y += 1
		env_y -= speed
		last_key = "down"
	
	#animations and movement
	if vel.length() > 0:
		vel = vel.normalized() * speed
		
		move_type = "MOVE"
		
		if last_key == "right":
			direction_sense = "RIGHT"
		if last_key == "left":
			direction_sense = "LEFT"
		if last_key == "up":
			direction_sense = "BACK"
		if last_key == "down":
			direction_sense = "FRONT"
	else:
		if last_key == "right":
			direction_sense = "RIGHT"
		if last_key == "left":
			direction_sense = "LEFT"
		if last_key == "up":
			direction_sense = "BACK"
		if last_key == "down":
			direction_sense = "FRONT"
		move_type = "IDLE"
		
	$AnimatedSprite.play(direction_sense + " " + move_type)
	
	position += vel * delta
