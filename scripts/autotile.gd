tool

extends TileMap

var tw = 100
var th = 100

#information is tabulated as follows:
#surrounding information : shape , x-flip, y-flip, transpose

var map_info = {
	0  : [0, false, false, false],
	1  : [1, false, false, false],
	2  : [1, false, false, true ],
	3  : [2, false, false, false],
	4  : [1, true , false, true ],
	5  : [2, true , false, false],
	6  : [0, false, false, false],
	7  : [0, false, false, false],
	8  : [1, false, true , false],
	9  : [0, false, false, false],
	10 : [2, false, true , false],
	11 : [0, false, false, false],
	12 : [2, true , true , false],
	13 : [0, false, false, false],
	14 : [0, false, false, false],
	15 : [0, false, false, false],
}

func _ready():
	update_all()
	set_process(true)

func _draw():
	update_all()

func set_tile(pos, type):
	var mpos = world_to_map(pos)
	var base = map_info[0]
	
	if type == "remove":
		set_cellv(mpos, -1, false, false, false)
	elif type == "template":
		set_cellv(mpos, base[0], base[1], base[2], base[3])
	
	update_tiles(mpos.x, mpos.y)

func update_tiles(i, j):
	update_tile(i, j)
	update_tile(i, j + 1)
	update_tile(i, j - 1)
	update_tile(i + 1, j)
	update_tile(i + 1, j + 1)
	update_tile(i + 1, j - 1)
	update_tile(i - 1, j)
	update_tile(i - 1, j + 1)
	update_tile(i - 1, j - 1)
	

func update_all():
	for i in range(tw):
		for j in range(th):
			if get_cell(i, j) != -1:
				update_tile(i, j)

func update_tile(i, j):
	if get_cell(i, j) != -1:
		var tid = get_surroundings(i, j)
		set_tile_shape(i, j, tid)

func get_surroundings(i, j):
	var tid = 0
	
	tid += (get_cell(i, j - 1) != -1) * 1
	tid += (get_cell(i - 1, j) != -1) * 2
	tid += (get_cell(i + 1, j) != -1) * 4
	tid += (get_cell(i, j + 1) != -1) * 8
	
	return tid

func set_tile_shape(i, j, tid):
	
	var tile = map_info[tid]
	
	set_cell(i, j, tile[0], tile[1], tile[2], tile[3])