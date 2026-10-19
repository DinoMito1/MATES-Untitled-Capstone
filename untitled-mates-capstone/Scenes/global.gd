extends Node2D

#room variables
@onready var currentRoom = 'TestScene'
@onready var roomEntrance = 1  # used for rooms with multiple entrances/exits to show which entrance you came in from.
#@onready var camLimitLeft = -10000
#@onready var camLimitRight = 10000
#@onready var camLimitUp = -10000
#@onready var camLimitDown = 10000
@onready var roomLoaded = false

#player variables
@onready var playerHealth = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
