class_name SceneBuilderToolbox

func get_all_node_names(_node):
	var _all_node_names = []
	for _child in _node.get_children():
		_all_node_names.append(_child.name)
		if _child.get_child_count() > 0:
			var _result = get_all_node_names(_child)
			for _item in _result:
				_all_node_names.append(_item)
	return _all_node_names

func increment_name_until_unique(new_name, all_names) -> String:
	if new_name in all_names:
		var backup_name = new_name
		var suffix_counter = 1
		var increment_until = true
		while (increment_until):
			var _backup_name = backup_name + "-n" + str(suffix_counter)
			if _backup_name in all_names:
				suffix_counter += 1
			else:
				increment_until = false
				backup_name = _backup_name
			if suffix_counter > 9000:
				print("suffix_counter is over 9000, error?")
				increment_until = false
		return backup_name
	else:
		return new_name

func replace_first(s: String, pattern: String, replacement: String) -> String:
	var index = s.find(pattern)
	if index == -1:
		return s
	return s.substr(0, index) + replacement + s.substr(index + pattern.length())

func replace_last(s: String, pattern: String, replacement: String) -> String:
	var index = s.rfind(pattern)
	if index == -1:
		return s
	return s.substr(0, index) + replacement + s.substr(index + pattern.length())

func get_unique_name(base_name: String, parent: Node) -> String:
	var new_name = "temporary_name"
	#var ends_with_digit = base_name.match(".*\\d+$")
	
	var ends_with_digit: bool = false
	if (base_name.length() > 0 and base_name[-1].is_valid_int()):
		ends_with_digit = true
	
	var regex = RegEx.new()
	regex.compile("^(.*?)(\\d+)$")
	
	print("Searching for a unique name...")
	
	if (parent.has_node(base_name)):
		new_name = base_name
		while parent.has_node(new_name):
			print("Existing name has been taken: " + new_name)
			if ends_with_digit:
				var result = regex.search(new_name)
				if result:
					var name_part = result.get_string(1)
					var num_part = int(result.get_string(2))
					new_name = name_part + str(num_part + 1)
				else:
					new_name = base_name + str(1)
			else:
				new_name = base_name + str(1)
	else:
		print("Existing name may be used as is.")
		new_name = base_name
	
	print("Returning: " + new_name)
	
	return new_name
