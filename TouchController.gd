class_name TouchController
extends OculusTracker
# Extension of the OculusTracker class to support the Oculus Touch controllers.


# Current button mapping for the touch controller
# godot itself also exposes some of these constants via JOY_VR_* and JOY_OCULUS_*
# this enum here is to document everything in place and includes the touch event mappings
enum CONTROLLER_BUTTON {
    YB = 1,
    GRIP_TRIGGER = 2, # grip trigger pressed over threshold
    ENTER = 3, # Menu Button on left controller

    TOUCH_XA = 5,
    TOUCH_YB = 6,

    XA = 7,

    TOUCH_THUMB_UP = 10,
    TOUCH_INDEX_TRIGGER = 11,
    TOUCH_INDEX_POINTING = 12,

    THUMBSTICK = 14, # left/right thumb stick pressed
    INDEX_TRIGGER = 15, # index trigger pressed over threshold
}

# Oculus mobile APIs available at runtime.
var ovr_guardian_system = null;
var ovr_input = null;
var ovr_tracking_transform = null;
var ovr_utilities = null;

# react to the worldscale changing
var _was_world_scale = 1.0

# Dictionary tracking the remaining duration for controllers vibration
var _controllers_vibration_duration = {}

onready var camera : ARVRCamera = origin.get_node("ARVRCamera")

func _ready():
    ovr_input = load("res://addons/godot_ovrmobile/OvrInput.gdns")
    if (ovr_input): ovr_input = ovr_input.new()

    ovr_guardian_system = load("res://addons/godot_ovrmobile/OvrGuardianSystem.gdns")
    if (ovr_guardian_system): ovr_guardian_system = ovr_guardian_system.new()

    ovr_tracking_transform = load("res://addons/godot_ovrmobile/OvrTrackingTransform.gdns")
    if (ovr_tracking_transform): ovr_tracking_transform = ovr_tracking_transform.new()

    ovr_utilities = load("res://addons/godot_ovrmobile/OvrUtilities.gdns")
    if (ovr_utilities): ovr_utilities = ovr_utilities.new()


func _process(delta_t):
    _check_worldscale(origin.world_scale)
    _update_controllers_vibration(delta_t)


func _get_tracker_label():
    return "Oculus Touch Left Controller" if controller_id == LEFT_TRACKER_ID else "Oculus Touch Right Controller"


func _start_controller_vibration(duration, rumble_intensity):
    print("Starting vibration of controller " + str(self) + " for " + str(duration) + "  at " + str(rumble_intensity))
    _controllers_vibration_duration[controller_id] = duration
    set_rumble(rumble_intensity)


func _update_controllers_vibration(delta_t):
    # Check if there are any controllers currently vibrating
    if (_controllers_vibration_duration.empty()):
        return

    # Update the remaining vibration duration for each controller
    for i in ARVRServer.get_tracker_count():
        var tracker = ARVRServer.get_tracker(i)
        if (_controllers_vibration_duration.has(tracker.get_tracker_id())):
            var remaining_duration = _controllers_vibration_duration[tracker.get_tracker_id()] - (delta_t * 1000)
            if (remaining_duration < 0):
                _controllers_vibration_duration.erase(tracker.get_tracker_id())
                tracker.set_rumble(0)
            else:
                _controllers_vibration_duration[tracker.get_tracker_id()] = remaining_duration


func _check_worldscale(world_scale):
    if _was_world_scale != world_scale:
        _was_world_scale = world_scale
        var inv_world_scale = 1.0 / _was_world_scale
        var controller_scale = Vector3(inv_world_scale, inv_world_scale, inv_world_scale)
        $TouchControllerModel.scale = -controller_scale if controller_id == RIGHT_TRACKER_ID else controller_scale
