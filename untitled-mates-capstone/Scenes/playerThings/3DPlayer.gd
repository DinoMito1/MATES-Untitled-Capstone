extends CharacterBody3D


const SPEED = 15.0
const JUMP_VELOCITY = 20.5

var mousePos
var mouseCenter
var mouseDifference

func _ready() -> void:
	mouseCenter = Vector2(get_viewport().get_visible_rect().size.x/2,get_viewport().get_visible_rect().size.x/2)
	$Marker3D.rotation_degrees.x = 0
	$Marker3D.rotation_degrees.y = 0
	
func _process(delta: float) -> void:
	if Global.gamePaused == false:
		mousePos = get_viewport().get_mouse_position()
		mouseDifference = mousePos - mouseCenter
		Input.warp_mouse(mouseCenter)
		if mouseDifference.x != 0:
			$Marker3D.rotation.y -= mouseDifference.x/ (200/Global.mouseSensitivity)
			
		if mouseDifference.y != 0:
			$Marker3D.rotation.x -= mouseDifference.y/ (200/Global.mouseSensitivity)
		
		if $Marker3D.rotation_degrees.x > 60:
			$Marker3D.rotation_degrees.x = 60
		elif $Marker3D.rotation_degrees.x < -75:
			$Marker3D.rotation_degrees.x = -75
	
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	#$"../cameraPivot".position = self.position

	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	#var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	var direction := (Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		#velocity = $Marker3D/Camera3D.basis * direction
		#$Marker3D/Camera3D.basis
		#print(direction)
		var camDirection = direction.rotated(Vector3.UP, $Marker3D.rotation.y)
		print(camDirection)
		velocity.x = camDirection.x * SPEED
		velocity.z = camDirection.z * SPEED
		#velocity.x = direction.x * SPEED # move local to camera
		#velocity.z = direction.z * SPEED
		#rotate character to face towards direction
		#rotation.y = lerp(rotation.y, camDirection.x, .1)
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
