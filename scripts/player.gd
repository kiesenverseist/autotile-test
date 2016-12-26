extends RigidBody2D

var spd = 10
var move = Vector2(0, 0)

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	
	edit_tile()
	
	move = Vector2(0,0)
	
	if Input.is_action_pressed("right"):
		move.x += spd
	
	if Input.is_action_pressed("left"):
		move.x -= spd
	
	move += get_pos()
	
	set_pos(move)

func edit_tile():
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		get_node("../TileMap").set_tile(get_global_mouse_pos(), "template")
	elif Input.is_mouse_button_pressed(BUTTON_RIGHT):
		get_node("../TileMap").set_tile(get_global_mouse_pos(), "remove")