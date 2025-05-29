extends Node

const WIDTH = 128;

var values = [];
var noise = FastNoiseLite.new();

var verts = [];
var indicies = [];

var generation_function: Callable;

var do_grid_draw = false;
var do_mesh_draw = false;
var animate_mesh = false;

func get_value(x, y):
	return values[x + y * WIDTH];

func set_value(x, y, value):
	values[x + y * WIDTH] = value;

func fill_values():
	for x in range(WIDTH):
		for y in range(WIDTH):
			set_value(x, y, generation_function.call(x, y));

func draw_grid():
	for x in range(WIDTH):
		for y in range(WIDTH):

			DebugDraw3D.draw_box_ab(Vector3(x - WIDTH / 2, y - WIDTH / 2, 0.0), Vector3(x + 1 - WIDTH / 2, y + 1 - WIDTH / 2, 1.0), Vector3.UP, Color.WHITE);
			DebugDraw3D.draw_square(Vector3(x - WIDTH / 2, y - WIDTH / 2, 2.0), 0.5, Color.RED * get_value(x,y))
			
func draw_mesh():

	for i in range(0, indicies.size(), 2):

		var index_0 = indicies[i]
		var index_1 = indicies[i + 1]
		var vert_0 = verts[index_0] - Vector2(WIDTH, WIDTH) / 2.0
		var vert_1 = verts[index_1] - Vector2(WIDTH, WIDTH) / 2.0


		DebugDraw3D.draw_line(Vector3(vert_0.x, vert_0.y, 4.0),Vector3(vert_1.x, vert_1.y, 4.0), Color.WHITE)

func get_indicies(x, y):
	return x + y * WIDTH;

func generate_mesh():
	verts.clear()
	indicies.clear();


	for y in range(WIDTH):
		for x in range(WIDTH):

			verts.append(Vector2(0.0, 0.0))
			var value = get_value(x, y)
			var vert_position = Vector2(0.0, 0.0);
			var count = 0;

			for i in range(0, 2):
				for j in range(0, 2):

					var offset = Vector2(i,j)
					if x + i >= WIDTH or y + j >= WIDTH or x + i < 0 or y + j < 0:
						continue;

					var value_2 = get_value(x + i, y + j)
					# We want to update our vert based on the intersection

					if value * value_2 < 0:
						# We have an intersection
						count += 1.0
						vert_position += offset * (-value / (value_2 - value))
						

					if i < 0 or j < 0 or i * j == 1 or y == 0 or x == 0:
						continue;


					if value_2 * value < 0:
						# Surface Here````

						indicies.append(get_indicies(x, y))
						indicies.append(get_indicies(x - j, y - i))

			if count > 0:
				vert_position /= count
				
			vert_position += Vector2(x, y)
			verts[verts.size()-1] = vert_position


func _ready() -> void:
	values.resize(WIDTH * WIDTH);

func _process(delta):


	fill_values()
	generate_mesh();
	if do_grid_draw:
		draw_grid()
	if do_mesh_draw:
		draw_mesh();

	pass
