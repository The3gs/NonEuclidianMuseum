extends Spatial



# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var state = RubicsCube.default_cube setget set_state
var portal = Portal.Desc.new() setget set_portal

export(int) var side = 0

func set_portal(data):
    portal = data
    
    _reload()
#    var p1 = Plane(portal.portal1.x, portal.portal1.y, portal.portal1.width, portal.portal1.rot)
#    var p2 = Plane(portal.portal2.x, portal.portal2.y, portal.portal2.width, portal.portal2.rot)
#    var mesh = $MeshInstance
#    var material = ShaderMaterial.new() if mesh.material_override == null else mesh.material_override
#    material.shader = preload("res://new_shader.shader")
#    material.set_shader_param("invert1", data.invert1)
#    material.set_shader_param("invert2", data.invert2)
#    material.set_shader_param("portal1", p1)
#    material.set_shader_param("portal2", p2)
#    var plaque_mesh = $Plaque
#    var plaque = ShaderMaterial.new() if plaque_mesh.material_override == null else plaque_mesh.material_override
#    plaque.shader = preload("res://new_shader.shader")
#    plaque.set_shader_param("invert1", portal.invert1)
#    plaque.set_shader_param("invert2", portal.invert2)
#    plaque.set_shader_param("portal1", p1)
#    plaque.set_shader_param("portal2", p2)
#    plaque.set_shader_param("texture_albedo", $Plaque/Viewport.get_texture())
#    plaque.set_shader_param("albedo", Color.white)
#    plaque.set_shader_param("uv1_scale", Vector3(1,1,1))
#    #seed(state.hash())
#    var piece = ArtInfo.art_pieces[randi() % len(ArtInfo.art_pieces)]
#    mesh.scale.x = piece.size.x
#    mesh.scale.z = piece.size.y
#    plaque_mesh.translation.x = piece.size.x / 2 + 0.1
#    material.set_shader_param("texture_albedo", piece.image)
#    material.set_shader_param("albedo", Color.white)
#    material.set_shader_param("uv1_scale", Vector3(1,1,1))
#    material.render_priority = 1
#    if mesh.material_override == null:
#        mesh.material_override = material
#
#    if plaque_mesh.material_override == null:
#        plaque_mesh.material_override = plaque


func set_state(value):
    state = value
    
    _reload()
#    var p1 = Plane(portal.portal1.x, portal.portal1.y, portal.portal1.width, portal.portal1.rot)
#    var p2 = Plane(portal.portal2.x, portal.portal2.y, portal.portal2.width, portal.portal2.rot)
#    var mesh = $MeshInstance
#    var material = ShaderMaterial.new() if mesh.material_override == null else mesh.material_override
#    var plaque_mesh = $Plaque
#    var plaque = ShaderMaterial.new() if plaque_mesh.material_override == null else plaque_mesh.material_override
#    material.shader = preload("res://new_shader.shader")
#    material.set_shader_param("invert1", portal.invert1)
#    material.set_shader_param("invert2", portal.invert2)
#    material.set_shader_param("portal1", p1)
#    material.set_shader_param("portal2", p2)
#    plaque.shader = preload("res://new_shader.shader")
#    plaque.set_shader_param("invert1", portal.invert1)
#    plaque.set_shader_param("invert2", portal.invert2)
#    plaque.set_shader_param("portal1", p1)
#    plaque.set_shader_param("portal2", p2)
#    #seed(state.hash())
#    var piece = ArtInfo.art_pieces[randi() % len(ArtInfo.art_pieces)]
#    mesh.scale.x = piece.size.x
#    mesh.scale.z = piece.size.y
#    plaque_mesh.translation.x = piece.size.x / 2 + 0.1
#    $Plaque/Viewport/VBoxContainer/Title.text = piece.title
#    $Plaque/Viewport/VBoxContainer/Description.text = piece.description
#    material.set_shader_param("texture_albedo", piece.image)
#    material.set_shader_param("albedo", Color.white)
#    material.set_shader_param("uv1_scale", Vector3(1,1,1))
#    material.render_priority = 1
#    if mesh.material_override == null:
#        mesh.material_override = material
#
#    if plaque_mesh.material_override == null:
#        plaque_mesh.material_override = plaque

func _reload():
    var p1 = Plane(portal.portal1.x, portal.portal1.y, portal.portal1.width, portal.portal1.rot)
    var p2 = Plane(portal.portal2.x, portal.portal2.y, portal.portal2.width, portal.portal2.rot)
    
    var mesh = $MeshInstance
    var material = mesh.material_override
    
    var piece = WorldData.get_painting(state, side)
    
    if material == null:
        material = ShaderMaterial.new()
        material.shader = preload("res://new_shader.shader")
        mesh.material_override = material
        material.set_shader_param("albedo", Color.white)
        material.set_shader_param("uv1_scale", Vector3(1,1,1))
    material.set_shader_param("invert1", portal.invert1)
    material.set_shader_param("invert2", portal.invert2)
    material.set_shader_param("portal1", p1)
    material.set_shader_param("portal2", p2)
    material.set_shader_param("texture_albedo", piece.image)
    
    mesh.scale.x = piece.size.x
    mesh.scale.z = piece.size.y
    
    var plaque_mesh = $Plaque
    var plaque_material = plaque_mesh.material_override
    if plaque_material == null:
        plaque_material = ShaderMaterial.new() if plaque_mesh.material_override == null else plaque_mesh.material_override
        plaque_material.shader = preload("res://new_shader.shader")
        plaque_material.set_shader_param("texture_albedo", $Plaque/Viewport.get_texture())
        plaque_material.set_shader_param("albedo", Color.white)
        plaque_material.set_shader_param("uv1_scale", Vector3(1,1,1))
        plaque_mesh.material_override = plaque_material
    plaque_material.set_shader_param("invert1", portal.invert1)
    plaque_material.set_shader_param("invert2", portal.invert2)
    plaque_material.set_shader_param("portal1", p1)
    plaque_material.set_shader_param("portal2", p2)
    
    plaque_mesh.translation.x = piece.size.x / 2 + 0.15
    $Plaque/Viewport/VBoxContainer/Artist.text = piece.artist
    $Plaque/Viewport/VBoxContainer/Title.text = piece.title
    $Plaque/Viewport/VBoxContainer/Description.text = piece.description
    
    material.render_priority = 1

func _ready():
    self.state = RubicsCube.default_cube
