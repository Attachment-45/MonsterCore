extends Area2D

#public variables
export var speed = 400
export var move_type = "IDLE"
export var direction_sense = "FRONT"
export var start_x = 0
export var start_y = 0

export var hp = 100

# variables
var can_move = true
var key_allows = [true, true, true, true] # up, down, left, right
var pre_pos_x = position.x
var pre_pos_y = position.y

var key_u = false
var key_d = false
var key_l = false
var key_r = false

var screen_size

var damageCounter = 0
var damageCounterNext = 100

var regenCounter = 0
var regenCounterNext = 100

func enemy_collisions():
	if get_overlapping_areas().size() > 0:
		var areas = get_overlapping_areas()
		for i in range(0, areas.size()):
			if areas[i].objectId == 1:
				if damageCounter == damageCounterNext:
					hp -= areas[i].damageRate
					damageCounterNext = OS.get_ticks_msec() + 1000
					get_node("Player-Cam").position.x = get_node("Player-Cam").screen_shake(100)
					get_node("Player-Cam").position.y = get_node("Player-Cam").screen_shake(100)
					$Hit.play()

func check_env_coll():
	if get_overlapping_areas().size() > 0:
		var areas = get_overlapping_areas()
		for i in range(0, areas.size()):
			if areas[i].objectId == 0:
				return false

func env_collisions(dt, sp):
	can_move = true
	if get_overlapping_areas().size() > 0:
		var areas = get_overlapping_areas()
		for i in range(0, areas.size()):
			if areas[i].objectId == 0:
				can_move = check_env_coll()
	
	if can_move == false:
		position.x = pre_pos_x
		position.y = pre_pos_y

#executions on load
func _ready():
	position.x = start_x
	position.y = start_y
	screen_size = get_viewport_rect().size

#updating executions
func _process(delta):
	if get_node("Player-Cam").position.x != 0:
		get_node("Player-Cam").position.x = 0
	
	if get_node("Player-Cam").position.y != 0:
		get_node("Player-Cam").position.y = 0
	
	# can move or not
	enemy_collisions()
	env_collisions(delta, speed)
	
	# damage counter
	damageCounter = OS.get_ticks_msec()
	if damageCounter > damageCounterNext:
		damageCounter = damageCounterNext
	elif damageCounter < 0:
		damageCounter = 0
	
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
	
	#input
	var last_key = ""
	var isMoving = false
	if Input.is_action_pressed("ui_right"):
		if can_move == true or key_allows[3]:
			pre_pos_x = position.x
			position.x += speed * delta
		else:
			position.x = pre_pos_x
			can_move = true
		last_key = "right"
		key_r = true
	else:
		key_r = false
	if Input.is_action_pressed("ui_left"):
		if can_move == true or key_allows[2]:
			pre_pos_x = position.x
			position.x -= speed * delta
		else:
			position.x = pre_pos_x
			can_move = true
		last_key = "left"
		key_l = true
	else:
		key_l = false
	if Input.is_action_pressed("ui_up"):
		if can_move == true or key_allows[0]:
			pre_pos_y = position.y
			position.y -= speed * delta
		else:
			position.y = pre_pos_y
			can_move = true
		last_key = "up"
		key_u = true
	else:
		key_u = false
	if Input.is_action_pressed("ui_down"):
		if can_move == true or key_allows[1]:
			pre_pos_y = position.y
			position.y += speed * delta
		else:
			position.y = pre_pos_y
			can_move = true
		last_key = "down"
		key_d = true
	else:
		key_d = false
	
	if key_u or key_d or key_l or key_r:
		isMoving = true
	else:
		isMoving = false
	
	if isMoving == true:
		if last_key == "right":
			direction_sense = "RIGHT"
		if last_key == "left":
			direction_sense = "LEFT"
		if last_key == "up":
			direction_sense = "BACK"
		if last_key == "down":
			direction_sense = "FRONT"
		move_type = "MOVE"
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
