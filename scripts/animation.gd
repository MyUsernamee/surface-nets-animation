class_name Animator
extends Node2D

var frames = [];
var waiting = false;
@onready var tween = get_tree().create_tween();
@export var camera: Camera3D;

func draw_method(method, duration, ease_time=0.5, add_pause=false):

	tween.tween_method(method
	, 0.0, 1.0, ease_time);

	if add_pause:
		wait_for_key()
	else:
		tween.tween_method(method
		, 1.0, 1.0, duration);

	tween.tween_method(method
	, 1.0, 0.0, ease_time);


func draw_text(text, position, duration, ease_time=0.5, size=32, color=Color.WHITE, add_pause = false):

	draw_method(func draw_hello(x):
		DebugDraw3D.draw_text(position, text, size, Color(color.r, color.g, color.b, x))
	, duration, ease_time, add_pause);

func set_camera(position, size):

	tween.tween_property(camera, "position",  position, 1.0,)
	tween.parallel().tween_property(camera, "size", size, 1.0,)

func wait_for_key():
	tween.tween_callback(func temp():
		waiting = true;
	)

@onready var circle_resource: PackedScene = load("res://scenes/circle.tscn")
@onready var circle_outline_resource: PackedScene = load("res://scenes/circle_outline.tscn")

func add_circle():
	var new_circle: Sprite3D = circle_resource.instantiate();
	add_child(new_circle)
	return new_circle

func add_circle_outline():
	var new_circle: Sprite3D = circle_outline_resource.instantiate();
	add_child(new_circle)
	return new_circle


func _ready():

	tween.set_trans(Tween.TRANS_EXPO)
	tween.pause()

	draw_text("Surface Nets", Vector3.ZERO, 1.0, 0.5, 128, Color.WHITE, true)
	draw_text("(INSERT SOME INSPIRATIONAL PHOTOS HERE LMAO)", Vector3.ZERO, 8.0, 0.5, 128, Color.WHITE, true)
	draw_text("SDF -> Mesh", Vector3.ZERO, 1.0, 0.25, 128, Color.WHITE, true)
	draw_text("SDF?????", Vector3.ZERO, 1.0, 0.25, 128, Color.WHITE, true)
	draw_text("d(x) -> float", Vector3.ZERO, 1.0, 0.25, 128, Color.WHITE, true) # TODO: Latex
	var reference_point = add_circle()
	reference_point.modulate = Color(1.0, 0.25, 0.25, 0);
	reference_point.scale = Vector3.ONE * 0.1;
	reference_point.position = Vector3(-1.0, 1.0, 0.0)
	var sdf_outline = add_circle_outline()
	sdf_outline.reparent(reference_point)
	sdf_outline.scale = Vector3.ZERO;
	sdf_outline.position = Vector3.ZERO;
	tween.tween_property(reference_point, "modulate:a", 1.0, 1.0);
	wait_for_key()
	tween.tween_callback(func temp():
		sdf_outline.modulate.a = 1.0
	)
	tween.tween_property(sdf_outline, "scale", Vector3.ONE * 10.0, 0.2);


func _process(delta: float) -> void:

	if waiting:
		waiting = waiting and not Input.is_key_pressed(KEY_SPACE)
		tween.custom_step(0.0000000000001)
	else:
		tween.custom_step(delta)
