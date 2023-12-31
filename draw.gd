extends Node2D

@onready var selecting = [$"Uİ/TopLeft",$"Uİ/TopRight"]
@onready var image = $Sprite2D

var start_point: Vector2
var end_point: Vector2
var actual_end_point: Vector2
var drawn := true
var drawn_list := []
var Class := 0
var object_list := []
var files: Array
var index := 0
var inMenu := true
var directory
var file_name


func  _draw() -> void:
	var image_size = image.texture.get_size()
	var rectangle = Rect2(start_point,end_point-start_point)
	draw_rect(rectangle,Color.AQUA,false)

	if drawn and (start_point != Vector2.ZERO and actual_end_point != Vector2.ZERO):
		var actual = Rect2(start_point,actual_end_point-start_point)
		draw_rect(actual,Color.RED,false)
		drawn_list.append(actual)
		for box in drawn_list:
			draw_rect(box,Color.RED,false)
		var center = Vector2(start_point.x + ((actual_end_point.x - start_point.x) / 2),
			start_point.y + ((actual_end_point.y-start_point.y) / 2))

		var x_center = center.x/image_size.x
		var y_center = center.y/image_size.y
		var width = (actual_end_point.x - start_point.x) / image_size.x
		var height = (actual_end_point.y - start_point.y) / image_size.y

		object_list.append(' '.join([str(Class),x_center,y_center,abs(width),abs(height)]))
		prints(object_list)

		draw_circle(center,2.5,Color.WHITE)
	#ChangeWindowSize(image_size)


func _input(_event: InputEvent) -> void:

	if get_local_mouse_position().x < image.texture.get_size().x / 2:
		$"Uİ/TopRight".visible = true
		$"Uİ/TopLeft".visible = false
	else:
		$"Uİ/TopLeft".visible = true
		$"Uİ/TopRight".visible = false

	if not $"Uİ/FileDialog".visible and inMenu:
		$"Uİ/FileDialog".visible = true

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

	if Input.is_key_pressed(KEY_1):
		selecting[0].text = 'Taşıt'
		selecting[1].text = 'Taşıt'
		Class = 0
	if Input.is_key_pressed(KEY_2):
		selecting[0].text = 'İnsan'
		selecting[1].text = 'İnsan'
		Class = 1
	if Input.is_key_pressed(KEY_3):
		selecting[0].text = 'UAP'
		selecting[1].text = 'UAP'
		Class = 2
	if Input.is_key_pressed(KEY_4):
		selecting[0].text = 'UAİ'
		selecting[1].text = 'UAİ'
		Class = 3
	if Input.is_physical_key_pressed(KEY_N):
		Nextİmage()
		ChangeWindowSize(image.texture.get_size())

	if Input.is_key_pressed(KEY_R):
		Reset()

func _on_file_dialog_dir_selected(dir: String) -> void:
	$Label.visible = false
	directory = dir
	inMenu = false
	Nextİmage()
	ChangeWindowSize(image.texture.get_size())


func ChangeWindowSize(image_size):
	get_viewport().size = image_size
	$"Uİ".size = image_size


func Nextİmage():
	files = DirAccess.get_files_at(directory+"/images/")

	if drawn_list != []:
		SaveData()

	if index <= (len(files) - 1):
		if FileAccess.file_exists(directory+"/images/"+files[index]):
			file_name = files[index]
			print(directory+"/images/"+files[index])
			print(file_name)
			var next_image = Image.load_from_file(directory+"/images/"+file_name)
			var texture = ImageTexture.create_from_image(next_image)
			image.texture = texture
			image.visible = true

	else:
		$"Uİ/NO MORE".visible = true
		$Sprite2D.visible = false
		await get_tree().create_timer(5).timeout
		get_tree().quit()



func SaveData():
	var data = ""
	if index <= (len(files) - 1):
		if file_name:
			file_name = files[index].split(".")[0]
			prints(file_name,"is saved")
			var file = FileAccess.open(directory+"/labels/"+file_name+".txt",FileAccess.WRITE)
			for i in object_list:
				data += (i + "\n")
			file.store_string(data)
			object_list = []
			index += 1

	drawn_list = []
	start_point = Vector2.ZERO
	end_point = Vector2.ZERO
	actual_end_point = Vector2.ZERO
	queue_redraw()


func Reset():
	drawn_list = []
	object_list = []

	start_point = Vector2.ZERO
	end_point = Vector2.ZERO
	actual_end_point = Vector2.ZERO
	queue_redraw()
