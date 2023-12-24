extends Node2D

var start_point: Vector2
var end_point: Vector2
var actual_end_point: Vector2
var drawn := true
var drawn_list := []


func  _draw() -> void:
	var picture_size = $Sprite2D.texture.get_size()
	var rectangle = Rect2(start_point,end_point-start_point)
	draw_rect(rectangle,Color.AQUA,false)

	if drawn and (start_point != Vector2.ZERO and actual_end_point != Vector2.ZERO):
		var actual = Rect2(start_point,actual_end_point-start_point)
		draw_rect(actual,Color.RED,false)
		drawn_list.append(actual)
		for box in drawn_list:
			draw_rect(box,Color.RED,false)
		print(drawn_list)
		var center = Vector2(start_point.x + ((actual_end_point.x - start_point.x) / 2),
			start_point.y + ((actual_end_point.y-start_point.y) / 2))

		var Class = 0
		var x_center = center.x/picture_size.x
		var y_center = center.y/picture_size.y
		var width = (actual_end_point.x - start_point.x) / picture_size.x
		var height = (actual_end_point.y - start_point.y) / picture_size.y

		prints(Class,x_center,y_center,width,height)

		draw_circle(center,2.5,Color.WHITE)

	get_viewport().size = $Sprite2D.texture.get_size()

func _input(event: InputEvent) -> void:
	#print(get_local_mouse_position())

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



