extends Node2D

var start_point: Vector2
var end_point: Vector2
var actual_end_point: Vector2

func  _draw() -> void:
	var rectangle = Rect2(start_point,end_point-start_point)
	draw_rect(rectangle,Color.AQUA,false)

	var actual = Rect2(start_point,actual_end_point-start_point)
	draw_rect(actual,Color.RED,false)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("left_click"):
		start_point = get_local_mouse_position()
	if Input.is_action_just_pressed("right_click"):
		actual_end_point = get_local_mouse_position()
		queue_redraw()

	end_point = get_local_mouse_position()
	queue_redraw()



