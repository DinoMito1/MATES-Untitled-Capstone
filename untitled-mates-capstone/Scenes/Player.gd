extends CharacterBody2D


const SPEED = 550.0
const JUMP_VELOCITY = -600.0
var time_since_floor_touch = 0.0 #used for coyote time (lets you jump for a moment after falling off an edge)
var can_jump = false

func _ready() -> void:
	$"../Camera2D".limit_left = $"../../leftCamLimit".position.x
	$"../Camera2D".limit_right = $"../../rightCamLimit".position.x
	$"../Camera2D".limit_top = $"../../upCamLimit".position.y
	$"../Camera2D".limit_bottom = $"../../downCamLimit".position.y

func _physics_process(delta: float) -> void:
	if velocity.x != 0:
		$"../Camera2D".position.x = self.position.x + (velocity.x)/6
	if velocity.y != 0:
		$"../Camera2D".position.y = self.position.y + (velocity.y/4)
	
	if not is_on_floor():
		velocity += get_gravity() * delta
		time_since_floor_touch += delta
	else:
		time_since_floor_touch = 0
		can_jump = true

	# Handle jump.
	if Input.is_action_just_pressed("jump") and time_since_floor_touch < .18 and can_jump == true:
		velocity.y = JUMP_VELOCITY
		$"../Camera2D".position
		can_jump = false

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
