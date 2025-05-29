class_name Animator
extends Node2D

var frames = [];
@onready var tween = get_tree().create_tween();
@export var camera: Camera3D;

func draw_method(method, duration, ease_time=0.5):


	tween.tween_method(method
	, 0.0, 1.0, ease_time);

	tween.tween_method(method
	, 1.0, 1.0, duration);

	tween.tween_method(method
	, 1.0, 0.0, ease_time);


func draw_text(text, position, duration, ease_time=0.5, size=32, color=Color.WHITE):

	draw_method(func draw_hello(x):
		DebugDraw3D.draw_text(position, text, size, Color(color.r, color.g, color.b, x))
	, duration, ease_time);

func set_camera(position, size):

	tween.tween_property(camera, "position",  position, 1.0,)
	tween.parallel().tween_property(camera, "size", size, 1.0,)

func _ready():

	tween.set_trans(Tween.TRANS_EXPO)

	draw_text("Hello!", Vector3.ZERO, 1.0, 0.5, 128)
	tween.set_parallel(true)
	set_camera(Vector3.ZERO, 10.0)
	tween.set_parallel(false)
