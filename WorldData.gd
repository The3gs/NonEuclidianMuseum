extends Node

var locations_objects = {}

func move_object(object: Node, old_location: Array, new_location: Array):
    var old_key = _get_key(old_location)
    var new_key = _get_key(new_location)
    if old_key in locations_objects:
        var index = locations_objects[old_key].find(object)
        locations_objects[old_key].remove(index)
    else:
        printerr("Location \"", old_location, "\" not found")
    
    if new_key in locations_objects:
        locations_objects[new_key].append(object)
    else:
        locations_objects[new_key] = [object]

func get_painting(room, side):
    seed((str(room) + str(side)).hash())
    return ArtInfo.art_pieces[randi() % len(ArtInfo.art_pieces)]

func get_objects(room):
    var key = _get_key(room)
    if key in locations_objects:
        return locations_objects[key]
    else:
        seed(key.hash())
        var list = _get_object_list(key, room)
        locations_objects[key] = list
        return list

func _get_object_list(key, room):
    if key == "0123456789abcdef":
        var node = ObjectInfo.objects[0].scene.instance()
        node.location = room
        node.translate(Vector3(0,1,0))
        return [node]
    if randi() % 2 == 0:
        return []
    else:
        var node = ObjectInfo.objects[randi() % len(ObjectInfo.objects)].scene.instance()
        node.location = room
        return [node] + _get_object_list(key, room)


func _get_key(puzzle):
    var ret = ""
    for cell in puzzle:
        ret += "0123456789abcdef"[cell]
    return ret
