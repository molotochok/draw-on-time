extends Node

func files_in_directory(dir_path) -> int:
	var count = 0
	
	var directory = Directory.new()
	var error = directory.open(dir_path)
	
	if error == OK:
		directory.list_dir_begin(true, true)
		
		var file_name = directory.get_next()
		while (file_name != ""):
			count += 1
			file_name = directory.get_next()
			
		directory.list_dir_end()
	
	return count
