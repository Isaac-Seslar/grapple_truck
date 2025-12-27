extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var max_speed := 1200.0
var vel := Vector2(0, 0)
var steering_factor := 3.0


#func _physics_process(delta: float) -> void:
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#move_and_slide()
func _process(delta: float) -> void:
	
	var direction := Vector2(0, 0)
	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down")
	

	if direction.length() > 1.0:
		direction = direction.normalized()
		

	var desired_velocity := max_speed * direction
	var steering := desired_velocity - vel
	vel += steering * steering_factor * delta
	position += vel * delta

	if vel.length() > 0.0:
		get_node("Sprite2D").rotation = velocity.angle()
		#get_node("UI").rotation = -velocity.angle()
		
	var viewport_size := get_viewport_rect().size
	position.x = wrapf(position.x, 0, viewport_size.x)
	position.y = wrapf(position.y, 0, viewport_size.y)
