extends Node2D

#room status variables - will be used to save and load loaction
@onready var currentRoom : String = 'TestScene'
@onready var roomEntrance : int = 1  # used for rooms with multiple entrances/exits to show which entrance you came in from.
@onready var roomLoaded : bool = false
@onready var playerDirection : int = 1 # the direction the player is facing. used for camera stuff. left is -1 right is 1. 0 will make camera focus directly on player

#ability unlocks
@onready var dashUnlocked : bool = true #should be false on game start but its true just for debug purposes

#player variables
@onready var playerHealth : int = 5

#Camera Stuff
@onready var camLocked : bool = false
@onready var lockedCameraPos : Vector2 = Vector2(0,0)
@onready var cameraMouseInfluence : float = 0.55

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
