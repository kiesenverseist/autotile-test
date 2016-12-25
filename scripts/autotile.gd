extends TileMap

var tw = 100
var th = 100

func _ready():
	for i in range(tw):
		for j in range(th):
			if get_cell(i, j) != -1:
				update_tile(i, j)

func update_tile(i, j):
	var tid = get_surroundings(i, j)
	tid = map_tid(tid)
	set_tile(i, j, tid)

func get_surroundings(i, j):
	var tid = 0
	
	tid += (get_cell(i, j - 1) != -1) * 1
	tid += (get_cell(i - 1, j) != -1) * 2
	
