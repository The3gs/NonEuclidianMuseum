extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(Vector2) var portal1Pos
export(float) var width1 = 0.5
export(float, -3.1415, 3.1415, 0.1) var rot1
export(bool) var invert1
export(Vector2) var portal2Pos
export(float) var width2 = 0.5
export(float, -3.1415, 3.1415, 0.1) var rot2
export(bool) var invert2

var state: Array setget set_state

func set_state(value):
    state = value
    for child in get_children():
        child.state = value

var portal

# Called when the node enters the scene tree for the first time.
func _ready():
    var portal1 = Portal.PortalData.new(portal1Pos.x, portal1Pos.y, width1, rot1)
    var portal2 = Portal.PortalData.new(portal2Pos.x, portal2Pos.y, width2, rot2)
    var data = Portal.Desc.new(portal1, portal2, invert1, invert2)
    portal = data
    #print(name, portal1Pos, portal2Pos, invert1, invert2)
    for child in get_children():
        child.portal = data


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
