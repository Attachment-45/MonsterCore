extends Node

export var pos_x = 0
export var pos_y = 0
export var off_x = 0
export var off_y = 0

var health_amt = 100

var tab_pressed = false

func _ready():
	pass

func _process(_delta):
	# positions
	pos_x = get_parent().get_node("Player").position.x + off_x
	pos_y = get_parent().get_node("Player").position.y + off_y
	
	# health
	health_amt = get_parent().get_node("Player").hp
	
	# show player data or not
	if Input.is_action_just_pressed("ui_home"):
		if get_node("Heart").visible == true:
			get_node("Heart").visible = false
		else:
			get_node("Heart").visible = true
		if get_node("Outline").visible == true:
			get_node("Outline").visible = false
		else:
			get_node("Outline").visible = true

func _input(event):
	if event is InputEventKey:
		if event.scancode == KEY_TAB:
			if tab_pressed == false:
				if get_node("Heart").visible == true:
					get_node("Heart").visible = false
				else:
					get_node("Heart").visible = true
				if get_node("Outline").visible == true:
					get_node("Outline").visible = false
				else:
					get_node("Outline").visible = true
				tab_pressed = true

