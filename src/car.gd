extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var max_speed := 1200.0
var vel := Vector2(0, 0)
var steering_factor := 5.0
var acceleration_factor := 0.3


func _process(delta: float) -> void:
	var throttle := Input.get_axis("accel","decel")
	var rotation_direction := Input.get_axis("turn_left", "turn_right")
	
	rotation += rotation_direction * delta
	var direction := Vector2.from_angle(rotation)
	var desired_velocity := max_speed * direction * throttle
	var steering := desired_velocity - vel
	vel += steering * steering_factor * acceleration_factor * delta 
	position += vel * delta
	
	print(vel)
	
	var viewport_size := get_viewport_rect().size
	position.x = wrapf(position.x, 0, viewport_size.x)
	position.y = wrapf(position.y, 0, viewport_size.y)
