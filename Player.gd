extends KinematicBody

var velocity = Vector3.ZERO
export var speed = 2
export var gravity = 9.8
export var mouse_speed = 0.01

onready var gui = $DebugGUI
onready var player = self

func _ready():
    Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
    if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
        rotate_y(-event.relative.x * mouse_speed)
        var cam = $Camera.rotation.x
        cam -= event.relative.y * mouse_speed
        $Camera.rotation.x = PI/2 if cam > PI/2 else cam if cam > -PI/2 else -PI/2
    
    if event.is_action_pressed("ui_cancel"):
        Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _unhandled_input(event):
    if event is InputEventMouseButton and event.is_pressed():
        Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _process(delta):
    velocity.x = 0
    velocity.z = 0
    if Input.is_action_pressed("move_forward"):
        velocity += -transform.basis.z * speed
    if Input.is_action_pressed("move_back"):
        velocity += transform.basis.z * speed
    if Input.is_action_pressed("move_left"):
        velocity += -transform.basis.x * speed
    if Input.is_action_pressed("move_right"):
        velocity += transform.basis.x * speed
    
    velocity += gravity * delta * Vector3.DOWN
    velocity = move_and_slide(velocity, Vector3.UP)
