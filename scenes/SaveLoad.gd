extends Node

const save_location = "res://SaveFile.json"

var contents_to_save: Dictionary = {
	"high_score": 0
}

func _save():
	# Open file location in write mode. Will create file if it does not exist. 
	var file = FileAccess.open(save_location, FileAccess.WRITE)
	# Save contents in dictionary to save file. Use duplicate to ensure we are copying the data and not 
	# using the original directly. 
	file.store_var(contents_to_save.duplicate())
	file.close()

func _load():
	if FileAccess.file_exists(save_location):
		var file = FileAccess.open(save_location, FileAccess.READ)
		var data = file.get_var()
		file.close()
		
		var save_data = data.duplicate()
		contents_to_save.high_score = save_data.high_score
