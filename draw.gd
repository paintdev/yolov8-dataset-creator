extends Node2D

var start_point: Vector2
var end_point: Vector2
var actual_end_point: Vector2
var drawn := false

func  _draw() -> void:
	var rectangle = Rect2(start_point,end_point-start_point)
	draw_rect(rectangle,Color.AQUA,false)

	if drawn:
		var actual = Rect2(start_point,actual_end_point-start_point)
		draw_rect(actual,Color.RED,false)

		var center = Vector2(start_point.x + ((actual_end_point.x - start_point.x) / 2),
			start_point.y + ((actual_end_point.y-start_point.y) / 2))
		draw_circle(center,2.5,Color.WHITE)

	get_viewport().size = $Sprite2D.texture.get_size()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("left_click"):
		start_point = get_local_mouse_position()
		drawn = false
	if Input.is_action_just_pressed("right_click"):
		actual_end_point = get_local_mouse_position()
		drawn = true
		queue_redraw()


	end_point = get_local_mouse_position()
	if not drawn:
		queue_redraw()



