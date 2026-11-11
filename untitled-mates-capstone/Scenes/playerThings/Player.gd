extends CharacterBody2D


const SPEED : float = 575.0
const JUMP_VELOCITY : float = -1050.0
var time_since_floor_touch : float = 0.0 #used for coyote time (lets you jump for a moment after falling off an edge)
var can_jump : bool = false

func _ready() -> void:
	$"../Camera2D".limit_left = $"../../leftCamLimit".position.x
	$"../Camera2D".limit_right = $"../../rightCamLimit".position.x
	$"../Camera2D".limit_top = $"../../upCamLimit".position.y
	$"../Camera2D".limit_bottom = $"../../downCamLimit".position.y

func _physics_process(delta: float) -> void:
	if Global.camLocked == false:
		$"../Camera2D".position.x = self.position.x + (get_local_mouse_position().x * Global.cameraMouseInfluence) + Global.playerDirection * 40
		$"../Camera2D".position.y = self.position.y + (get_local_mouse_position().y * Global.cameraMouseInfluence)
	else: # if camera is locked
		$"../Camera2D".position = Global.lockedCameraPos + (get_local_mouse_position() * Global.cameraMouseInfluence)
		
	if Global.playerDirection != $CollisionShape2D.scale.x:
		$CollisionShape2D.scale.x = Global.playerDirection #after anim
		#play turn around anim. should be quick maybe like 5 frames or so. anims will prbably be 24 fps
		
		
	if not is_on_floor():
		velocity += get_gravity() * delta
		time_since_floor_touch += delta
	else:
		time_since_floor_touch = 0
		can_jump = true

	# Handle jump.
	if Input.is_action_just_pressed("jump") and time_since_floor_touch < .18 and can_jump == true: # time_since_floor_touch is how many seconds the player can falling and still be able to jump
		velocity.y = JUMP_VELOCITY
		can_jump = false

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		Global.playerDirection = direction
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	

	move_and_slide()
