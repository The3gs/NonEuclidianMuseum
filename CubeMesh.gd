extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var state = RubicsCube.default_cube setget set_state
var portal = Portal.Desc.new() setget set_portal

func set_portal(data):
    portal = data
    for child in get_children():
        var p1 = Plane(data.portal1.x, data.portal1.y, data.portal1.width, data.portal1.rot)
        var p2 = Plane(data.portal2.x, data.portal2.y, data.portal2.width, data.portal2.rot)
        if child is MeshInstance:
            var material = ShaderMaterial.new() if child.material_override == null else child.material_override
            material.shader = preload("res://new_shader.shader")
            material.set_shader_param("invert1", data.invert1)
            material.set_shader_param("invert2", data.invert2)
            material.set_shader_param("portal1", p1)
            material.set_shader_param("portal2", p2)
            material.set_shader_param("albedo", Color.darkgray)
            child.material_override = material
        else:
            for i in len(child.get_children()):
                var mesh = child.get_child(i)
                var material = ShaderMaterial.new() if mesh.material_override == null else mesh.material_override
                material.shader = preload("res://new_shader.shader")
                material.set_shader_param("invert1", data.invert1)
                material.set_shader_param("invert2", data.invert2)
                material.set_shader_param("portal1", p1)
                material.set_shader_param("portal2", p2)
                material.set_shader_param("albedo", RubicsCube.colors[state[i]])
                material.render_priority = 1
                if mesh.material_override == null:
                    mesh.material_override = material


func set_state(value):
    state = value
    var p1 = Plane(portal.portal1.x, portal.portal1.y, portal.portal1.width, portal.portal1.rot)
    var p2 = Plane(portal.portal2.x, portal.portal2.y, portal.portal2.width, portal.portal2.rot)
    for i in len($Side.get_children()):
        var material = ShaderMaterial.new() if $Side.get_child(i).material_override == null else $Side.get_child(i).material_override
        material.shader = preload("res://new_shader.shader")
        material.set_shader_param("invert1", portal.invert1)
        material.set_shader_param("invert2", portal.invert2)
        material.set_shader_param("portal1", p1)
        material.set_shader_param("portal2", p2)
        material.set_shader_param("albedo", RubicsCube.colors[state[i]])
        material.render_priority = 1
        if $Side.get_child(i).material_override == null:
            $Side.get_child(i).material_override = material

# Called when the node enters the scene tree for the first time.
func _ready():
    self.state = RubicsCube.default_cube
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
