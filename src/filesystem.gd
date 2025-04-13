extends Control

@onready var editor = $MarginContainer/Content/TextEdit
@onready var open = $OpenFile
@onready var save = $SaveFile

@onready var file_menu = $MarginContainer/Content/Menubar/File

var cur_file = "untitled"
var file_name = "untitled"

func _ready():
	var menu = file_menu.get_popup()
	menu.connect("id_pressed", _dialog)
	
	open.connect("file_selected", read)
	save.connect("file_selected", write)

func _dialog(id):
	match id:
		0: open_file()
		1: save_file()
		2: saveas()
		3: create()

func save_file():
	if cur_file == "":
		save.popup_centered()
	else:
		write(cur_file)

func open_file():
	open.popup_centered()

func saveas():
	save.popup_centered()

func create():
	if cur_file != "":
		save_file()
		editor.text = ""
		cur_file = "untitled"
		file_name = "untitled"

func read(path):
	var file = FileAccess.open(path, FileAccess.READ)
	if file:
		editor.text = file.get_as_text()
		cur_file = path
		file_name = path.get_file()
		file.close()

func write(path):
	var file = FileAccess.open(path, FileAccess.WRITE)
	if file:
		file.store_string(editor.text)
		file.close()
