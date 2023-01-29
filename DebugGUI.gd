extends Control


var location setget set_location

func set_location(value):
    $CurrentLocation.text = value

var debug_sphere setget , get_sphere

func get_sphere():
    return Vector2($DebugObject/HSlider.value, $DebugObject/HSlider2.value)
