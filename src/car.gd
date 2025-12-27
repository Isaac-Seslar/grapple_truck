extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var max_speed := 1200.0
var vel := Vector2(0, 0)
var steering_factor := 3.0


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
		get_node("Sprite2D").rotation = vel.angle()
		
	var viewport_size := get_viewport_rect().size
	position.x = wrapf(position.x, 0, viewport_size.x)
	position.y = wrapf(position.y, 0, viewport_size.y)
