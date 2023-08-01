class_name ItemPool extends Resource

##TODO: PLACEHOLDER ##
var items_folder_path := "res://item/components/custom_components/"
var all_items = []

func _init():
	all_items = list_files_in_directory(items_folder_path)


## returns the file name NOT the entire path ##
func list_files_in_directory(path):
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()

	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			files.append(file)
	
	dir.list_dir_end()
	return files
