extends Node

class PortalData:
    func _init(x: float, y: float, width: float, rot: float):
        self.x = x
        self.y = y
        self.width = width
        self.rot = rot
    var x: float
    var y: float
    var width: float
    var rot: float

var Nportal = PortalData.new(0.4, 0.0, 0.5, 1.6)
var Sportal = PortalData.new(-0.4, 0.0, 0.5, 1.6)
var Wportal = PortalData.new(0.0, -0.4, 0.5, 0.0)
var Eportal = PortalData.new(0.0, 0.4, 0.5, 0.0)

class Desc:
    func _init(p1: PortalData = PortalData.new(0.0, 0.5, 0.5, 0.0), p2: PortalData = PortalData.new(0.0, -0.5, 0.5, 0.0), i1: bool = false, i2: bool = false):
        self.portal1 = p1
        self.portal2 = p2
        self.invert1 = i1
        self.invert2 = i2
    var portal1: PortalData
    var portal2: PortalData
    var invert1: bool
    var invert2: bool

func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
