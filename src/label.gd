extends Node

@onready var editor = $"../../TextEdit"
@onready var left = $"."
@onready var right = $"../RightLabel"
@onready var fs = $"../../../.."

func _process(delta): 
	var row = editor.get_caret_line()
	var column = editor.get_caret_column()
	var file_name = fs.file_name
	
	var cursor_pos = "(%s, %s)" % [row, column]
	var char_counts = "%s chars" % [editor.text.length()]
	
	var char_info = "%s | %s" % [char_counts, cursor_pos]
	var file_info = "%s" % [file_name]
	
	left.text = char_info
	right.text = file_info
