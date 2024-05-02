extends Node

enum TOOLTYPE {NONE, CARROT, ONION}
var SELECTEDTOOL = TOOLTYPE.NONE

func dir(class_instance):
	var output = {}
	var methods = []
	for method in class_instance.get_method_list():
		methods.append(method.name)
	
		output["METHODS"] = methods
	
		var properties = []
		for prop in class_instance.get_property_list():
			if prop.type == 3:
				properties.append(prop.name)
			output["PROPERTIES"] = properties
			return output
