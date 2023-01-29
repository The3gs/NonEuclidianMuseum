extends Spatial

var player # Player's body (Either the root of the player or ARVRCamera)
var gui # Debug GUI (Either a normal GUI, or attached to left hand)

# Called when the node enters the scene tree for the first time.
func _ready():
	var vrplayer = preload("res://ARVRPlayer.tscn")
	var regularplayer = preload("res://Player.tscn")
	var player_base
	if OS.get_name() == "Android": # is running on the quest.
		player_base = vrplayer.instance()
	else:
		player_base = regularplayer.instance()
	add_child(player_base)
	gui = player_base.gui
	player = player_base.player
	
	p_start = player.global_transform.origin
	last_player_loc = Vector2(p_start.x, p_start.z)
	
	$CurrentRoom.state = current_cube
	for i in range(12):
		var nxt = RubicsCube.make_move(current_cube, turns[i][0])
		var nxt2 = RubicsCube.make_move(nxt, turns[i][1])
		$SubRooms.get_child(i).state = nxt2
		if shown_portals[player_segment][i] == 1:
			$SubRooms.get_child(i).show()
		else:
			$SubRooms.get_child(i).hide()
	$Center/Center.portal = Portal.Desc.new(
		Portal.PortalData.new(100, 100, 0, 0), # I just have 0 width portals  because I am not using the portals.
		Portal.PortalData.new(-100, 100, 0, 0),
		true, true
	   )
	
	$Center/N.portal = Portal.Desc.new(
		Portal.Nportal,
		Portal.Nportal,
		false, false
	   )
	
	$Center/S.portal = Portal.Desc.new(
		Portal.Sportal,
		Portal.Sportal,
		false, false
	   )
	
	$Center/E.portal = Portal.Desc.new(
		Portal.Eportal,
		Portal.Eportal,
		false, false
	   )
	
	$Center/W.portal = Portal.Desc.new(
		Portal.Wportal,
		Portal.Wportal,
		false, false
	   )
	
	detect_move(true)


enum Dir{
	C,
	N,
	NNE,
	NEE,
	E,
	SEE,
	SSE,
	S,
	SSW,
	SWW,
	W,
	NWW,
	NNW
}

var shown_portals = [
	#NNNWESEEENSWSSSEWNWWWSNEN S E W
	[0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1], #C
	[0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0], #N
	[0,0,0,0,0,1,1,0,0,0,1,0,0,0,0,0], #NNE
	[0,0,0,0,0,1,0,0,0,1,1,0,0,0,0,0], #NEE
	[0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0], #E
	[0,1,0,0,0,0,0,0,1,1,0,0,0,0,0,0], #SEE
	[1,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0], #SSE
	[1,1,0,0,0,0,0,0,0,0,0,1,0,0,0,0], #S
	[1,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0], #SSW
	[0,0,0,1,1,0,0,0,0,0,0,1,0,0,0,0], #SWW
	[0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0], #W
	[0,0,1,1,0,0,0,1,0,0,0,0,0,0,0,0], #NWW
	[0,0,1,0,0,0,1,1,0,0,0,0,0,0,0,0]  #NNW
   ]

# N=0, S=1, E=2, W=3
var turns = [
	[0, 0],
	[0, 3],
	[2, 1],
	[2, 2],
	[2, 0],
	[1, 3],
	[1, 1],
	[1, 2],
	[3, 0],
	[3, 3],
	[3, 1],
	[0, 2],
	[0],
	[2],
	[1],
	[3]
   ]

var c_layers = [
	0b00000000000000000010,
	0b00000000000000000100,
	0b00000000000000001000,
	0b00000000000000010000,
	0b00000000000000100000,
	0b00000000000001000000,
	0b00000000000010000000,
	0b00000000000100000000,
	0b00000000001000000000,
	0b00000000010000000000,
	0b00000000100000000000,
	0b00000001000000000000,
	0b00000010000000000000,
	0b00000100000000000000,
	0b00001000000000000000,
	0b00010000000000000000,
	0b00100000000000000000,
	0b01000000000000000000,
	0b10000000000000000000
   ]

var c_masks = [
	0b00000000000000000011,
	0b00000000000000000101,
	0b00000000000000001001,
	0b00000000000000010001,
	0b00000000000000100001,
	0b00000000000001000001,
	0b00000000000010000001,
	0b00000000000100000001,
	0b00000000001000000001,
	0b00000000010000000001,
	0b00000000100000000001,
	0b00000001000000000001,
	0b00000010000000000001,
	0b00000100000000000001,
	0b00001000000000000001,
	0b00010000000000000001,
	0b00100000000000000001,
	0b01000000000000000001,
	0b10000000000000000001
	
   ]

var collisions

var current_cube = RubicsCube.default_puzzle#RubicsCube.default_cube

# Called every frame. 'delta' is the elapsed time since the previous frame.
var p_start
var last_player_loc: Vector2
var player_segment = Dir.C
func _physics_process(delta):
	detect_move(false)

func object_moved():
	detect_move(true)

func detect_move(force_update: bool):
	var loc = player.global_transform.origin
	var new_loc = Vector2(loc.x, loc.z)
	var changed = true
	if (abs(new_loc.x) < 0.5 and abs(new_loc.y) < 0.5 and 
		(abs(last_player_loc.x) >= 0.5 or abs(last_player_loc.y) >= 0.5)):
			match player_segment:
				Dir.NNE:
					continue
				Dir.NNW:
					continue
				Dir.N:
					current_cube = RubicsCube.make_move(current_cube, 1)
				Dir.SSE:
					continue
				Dir.SSW:
					continue
				Dir.S:
					current_cube = RubicsCube.make_move(current_cube, 0)
				Dir.SEE:
					continue
				Dir.NEE:
					continue
				Dir.E:
					current_cube = RubicsCube.make_move(current_cube, 3)
				Dir.SWW:
					continue
				Dir.NWW:
					continue
				Dir.W:
					current_cube = RubicsCube.make_move(current_cube, 2)
			player_segment = Dir.C
	elif ((abs(new_loc.x) > 0.5 or abs(new_loc.y) > 0.5) and 
		(abs(last_player_loc.x) <= 0.5 and abs(last_player_loc.y) <= 0.5)):
			if new_loc.x > 0.5:
				player_segment = Dir.N
				current_cube = RubicsCube.make_move(current_cube, 0)
			elif new_loc.x < -0.5:
				player_segment = Dir.S
				current_cube = RubicsCube.make_move(current_cube, 1)
			elif new_loc.y > 0.5:
				player_segment = Dir.E
				current_cube = RubicsCube.make_move(current_cube, 2)
			elif new_loc.y < -0.5:
				player_segment = Dir.W
				current_cube = RubicsCube.make_move(current_cube, 3)
	elif (player_segment == Dir.C):
		changed=false
	elif (new_loc.x > 0.5 and last_player_loc.x <= 0.5):
		if player_segment == Dir.E:
			player_segment = Dir.NEE
		if player_segment == Dir.W:
			player_segment = Dir.NWW
	elif (new_loc.x < 0.5 and last_player_loc.x >= 0.5):
		if player_segment == Dir.NEE:
			player_segment = Dir.E
		if player_segment == Dir.NWW:
			player_segment = Dir.W
	elif (new_loc.x > -0.5 and last_player_loc.x <= -0.5):
		if player_segment == Dir.SEE:
			player_segment = Dir.E
		if player_segment == Dir.SWW:
			player_segment = Dir.W
	elif (new_loc.x < -0.5 and last_player_loc.x >= -0.5):
		if player_segment == Dir.E:
			player_segment = Dir.SEE
		if player_segment == Dir.W:
			player_segment = Dir.SWW
	elif (new_loc.y > 0.5 and last_player_loc.y <= 0.5):
		if player_segment == Dir.N:
			player_segment = Dir.NNE
		if player_segment == Dir.S:
			player_segment = Dir.SSE
	elif (new_loc.y < 0.5 and last_player_loc.y >= 0.5):
		if player_segment == Dir.NNE:
			player_segment = Dir.N
		if player_segment == Dir.SSE:
			player_segment = Dir.S
	elif (new_loc.y > -0.5 and last_player_loc.y <= -0.5):
		if player_segment == Dir.NNW:
			player_segment = Dir.N
		if player_segment == Dir.SSW:
			player_segment = Dir.S
	elif (new_loc.y < -0.5 and last_player_loc.y >= -0.5):
		if player_segment == Dir.N:
			player_segment = Dir.NNW
		if player_segment == Dir.S:
			player_segment = Dir.SSW
	elif (new_loc.x - new_loc.y > 0) != (last_player_loc.x - last_player_loc.y > 0):
		if player_segment == Dir.NNE:
			player_segment = Dir.NEE
		elif player_segment == Dir.NEE:
			player_segment = Dir.NNE
		elif player_segment == Dir.SSW:
			player_segment = Dir.SWW
		elif player_segment == Dir.SWW:
			player_segment = Dir.SSW
	elif (new_loc.x + new_loc.y > 0) != (last_player_loc.x + last_player_loc.y > 0):
		if player_segment == Dir.NNW:
			player_segment = Dir.NWW
		elif player_segment == Dir.NWW:
			player_segment = Dir.NNW
		elif player_segment == Dir.SSE:
			player_segment = Dir.SEE
		elif player_segment == Dir.SEE:
			player_segment = Dir.SSE
	else:
		changed = false
	if changed or force_update:
		#print(Dir.keys()[player_segment])
		if player_segment == Dir.C:
			$Center/Center.state = current_cube
			for obj in WorldData.get_objects(current_cube):
				obj.connect("moved", self, "object_moved")
				if obj.get_parent() != null:
					obj.get_parent().remove_child(obj)
				obj.collision_layer = c_layers[0]
				obj.collision_mask = c_masks[0]
				$Objects.add_child(obj)
				obj.portal = Portal.Desc.new(
					Portal.PortalData.new(100, 100, 0, 0), # I just have 0 width portals  because I am not using the portals.
					Portal.PortalData.new(-100, 100, 0, 0),
					true, true
				)
			$CurrentRoom.hide()
			$Center/Center.show()
			$Center/N.hide()
			$Center/S.hide()
			$Center/E.hide()
			$Center/W.hide()
		else:
			$CurrentRoom.state = current_cube

			for obj in WorldData.get_objects(current_cube):
				obj.connect("moved", self, "object_moved")
				if obj.get_parent() != null:
					obj.get_parent().remove_child(obj)
				obj.collision_layer = c_layers[0]
				obj.collision_mask = c_masks[0]
				$Objects.add_child(obj)
				obj.portal = $CurrentRoom.portal
			$Center/N.state = RubicsCube.make_move(current_cube, 1)
			$Center/S.state = RubicsCube.make_move(current_cube, 0)
			$Center/E.state = RubicsCube.make_move(current_cube, 3)
			$Center/W.state = RubicsCube.make_move(current_cube, 2)
			$CurrentRoom.show()
			$Center/Center.hide()
			$Center/N.show()
			$Center/S.show()
			$Center/W.show()
			$Center/E.show()
		for i in range(16):
			if shown_portals[player_segment][i] == 1:
				$SubRooms.get_child(i).show()
				var nxt = RubicsCube.make_move(current_cube, turns[i][0])
				var nxt2 = nxt
				if len(turns[i]) > 1:
					nxt2 = RubicsCube.make_move(nxt, turns[i][1])
				for obj in WorldData.get_objects(nxt2):
					obj.connect("moved", self, "object_moved")
					obj.collision_layer = c_layers[i + 1]
					obj.collision_mask = c_masks[i + 1]
					if obj.get_parent() != null:
						obj.get_parent().remove_child(obj)
					$Objects.add_child(obj)
					obj.portal = $SubRooms.get_child(i).portal
				$SubRooms.get_child(i).state = nxt2
			else:
				$SubRooms.get_child(i).hide()
	
	last_player_loc = new_loc
	gui.location = print_puzzle(current_cube)
	var dbg_obj: Vector2 = gui.debug_sphere
	if $DebugSphere:
		$DebugSphere.translation.x = -1.4 + 2.8 * dbg_obj.x
		$DebugSphere.translation.z = -1.4 + 2.8 * dbg_obj.y
	update_debug_sphere()

func update_debug_sphere():
	pass

func print_puzzle(puzzle):
	var i = 0
	var ret = ""
	for cell in puzzle:
		if cell < 10:
			ret += " "
		ret += str(cell)
		i += 1
		if i % 4 == 0:
			ret += "\n"
		else:
			ret += " "
	return ret
