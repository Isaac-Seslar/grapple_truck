extends Camera2D

@export var zoom_speed : float = 0.3
@export var max_zoom : float = 5.00
@export var min_zoom : float = 1.00

func _unhandled_input(event: InputEvent) -> void:
	var zoom_dir : int = 0
	
	if event.is_action_pressed("zoom_in"):
		zoom_dir += 1
	
	if event.is_action_pressed("zoom_out"):
		zoom_dir -= 1
	
	var new_zoom : float = zoom.x + (zoom_speed*zoom_dir)
	new_zoom = clamp(new_zoom, min_zoom, max_zoom)
	zoom = Vector2(new_zoom, new_zoom)
