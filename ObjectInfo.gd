extends Node

class WorldObject:
    func _init(scene: PackedScene):
        self.scene = scene
    var scene: PackedScene

var objects = [
    WorldObject.new(preload("res://objects/ball.tscn")),
    WorldObject.new(preload("res://objects/Book1.tscn")),
    WorldObject.new(preload("res://objects/Book2.tscn")),
    WorldObject.new(preload("res://objects/Book3.tscn")),
    WorldObject.new(preload("res://objects/Book4.tscn")),
   ]
