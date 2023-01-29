extends RigidBody

export(Texture) var albedo_texture

signal moved

var location = RubicsCube.default_puzzle

var state # Unused

var loc = Vector2(global_transform.origin.x, global_transform.origin.z)

var portal setget set_portal

func set_portal(value):
    portal = value
    
    var p1 = Plane(portal.portal1.x, portal.portal1.y, portal.portal1.width, portal.portal1.rot)
    var p2 = Plane(portal.portal2.x, portal.portal2.y, portal.portal2.width, portal.portal2.rot)
    
    var material = $Mesh.material_override
    if material == null:
        material = ShaderMaterial.new()
        material.shader = preload("res://new_shader.shader")
        $Mesh.material_override = material
        material.set_shader_param("albedo", Color.white)
        material.set_shader_param("uv1_scale", Vector3(1,1,1))
    material.set_shader_param("invert1", portal.invert1)
    material.set_shader_param("invert2", portal.invert2)
    material.set_shader_param("portal1", p1)
    material.set_shader_param("portal2", p2)
    material.set_shader_param("texture_albedo", albedo_texture)
    
    material.render_priority = 1
    

func _physics_process(delta):
    var new_loc = Vector2(global_transform.origin.x, global_transform.origin.z)
    if max(abs(loc.x), abs(loc.y)) <= 0.5: #if was in center
        if new_loc.x > 0.5:
            _move(0)
        elif new_loc.x < -0.5:
            _move(1)
        elif new_loc.y > 0.5:
            _move(2)
        elif new_loc.y < -0.5:
            _move(3)
    elif max(abs(new_loc.x), abs(new_loc.y)) <= 0.5: # if now in center
        if loc.x > 0.5:
            _move(1)
        elif loc.x < -0.5:
            _move(0)
        elif loc.y > 0.5:
            _move(3)
        elif loc.y < -0.5:
            _move(2)
    else:
        pass
    loc = new_loc

func _move(dir):
    var new_location = RubicsCube.make_move(location, dir)
    WorldData.move_object(self, location, new_location)
    get_parent().remove_child(self)
    location = new_location
    emit_signal("moved")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
