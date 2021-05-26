extends Area2D

#public variables
export var speed = 400
export var move_type = "IDLE"
export var direction_sense = "FRONT"
export var start_x = 0
export var start_y = 0

export var hp = 100

export var env_x = 0
export var env_y = 0

# variables
var can_move = true
var key_allows = [false, false, false, false] # up, down, left, right
var pre_pos_x = position.x
var pre_pos_y = position.y

var screen_size

var damageCounter = 0
var damageCounterNext = 100

var regenCounter = 0
var regenCounterNext = 100

#executions on load
func _ready():
	position.x = start_x
	position.y = start_y
	screen_size = get_viewport_rect().size

#updating executions
func _process(delta):
	var last_key = ""
	
	var vel = Vector2()
	
	# damage counter
	damageCounter = OS.get_ticks_msec()
	if damageCounter > damageCounterNext:
		damageCounter = damageCounterNext
	elif damageCounter < 0:
		damageCounter = 0
	
	# can move or not
	if get_overlapping_areas().size() > 0:
		var areas = get_overlapping_areas()
		for i in range(0, areas.size()):
			if areas[i].objectId == 0:
				can_move = false
			elif areas[i].objectId == 1:
				if damageCounter == damageCounterNext:
					hp -= areas[i].damageRate
					damageCounterNext = OS.get_ticks_msec() + 1000
	
	# health system
	regenCounter = OS.get_ticks_msec()
	if regenCounter > regenCounterNext:
		regenCounter = regenCounterNext
	if regenCounter == regenCounterNext:
		hp += 1
		regenCounterNext = OS.get_ticks_msec() + 1000
	if hp > 100:
		hp = 100
	if hp < 0:
		hp = 0
	
	if can_move == true:
		key_allows = [true, true, true, true]
		pre_pos_x = position.x
		pre_pos_y = position.y
	
	if can_move == false:
		position.x = pre_pos_x
		position.y = pre_pos_y
		can_move = true
	
	#input
	if Input.is_action_pressed("ui_right") and key_allows[3]:
		vel.x += 1
		env_x -= speed
		last_key = "right"
	if Input.is_action_pressed("ui_left") and key_allows[2]:
		vel.x -= 1
		env_x += speed
		last_key = "left"
	if Input.is_action_pressed("ui_up") and key_allows[0]:
		vel.y -= 1
		env_y += speed
		last_key = "up"
	if Input.is_action_pressed("ui_down") and key_allows[1]:
		vel.y += 1
		env_y -= speed
		last_key = "down"
	
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
	
