extends CharacterBody2D

@export var max_speed : float = 4000.0
@export var acceleration : float = 1000.0
@export var friction : float = 200.0
@export var turn_speed : float = 5.0

var speed : float = 0.0

var throttle : int = 0
var steer : int = 0
var brake : int = 0

func _process(delta: float) -> void:
	speed += throttle*acceleration*delta
	apply_friction(delta)
	speed = clamp(speed, -max_speed, max_speed)
	velocity = -transform.y * speed
	var speed_ratio : float = abs(speed) / max_speed
	var steering_factor : float = min(speed_ratio * 4.0, 1.0)
	
	var collision = move_and_collide(velocity * delta)
	if collision:
		#velocity = velocity.slide(collision.get_normal())
		speed = 0

	rotation += steer * turn_speed * steering_factor * delta
	print(speed)
	print(velocity)
	
	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	
	throttle = 0
	if Input.is_action_pressed("move_forward"):
		throttle += 1
	
	if Input.is_action_pressed("move_backward"):
		throttle -= 1
	
	steer = 0
	if Input.is_action_pressed("turn_right"):
		steer += 1
	
	if Input.is_action_pressed("turn_left"):
		steer -= 1
	
	brake = 0
	if Input.is_action_pressed("brake"):
		brake += 1

func apply_friction(delta : float) -> void:
	var total_friction : float = friction + (brake * friction * 20)
	var deceleration : float = total_friction * delta
	
	if abs(speed) < deceleration:
		speed = 0
	else:
		speed -= sign(speed)*deceleration
