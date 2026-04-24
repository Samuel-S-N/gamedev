extends Camera2D

var smooth_speed: float = 5.0
var zoom_speed: float = 3.0

var min_zoom: float = 0.7
var max_zoom: float = 1.5
var zoom_margin: float = 200.0

func _process(delta: float) -> void:
	# 1. Puxamos as referências diretamente da sua variável Global!
	# Isso garante que a câmera sempre saiba quem são os jogadores no Fits on Fire.
	var player1 = Global.player1
	var player2 = Global.player2

	var targets: Array[Vector2] = []
	
	# Verifica quem está vivo
	if is_instance_valid(player1) and player1.is_alive and player1.is_playing: 
		targets.append(player1.global_position)
	if is_instance_valid(player2) and player2.is_alive and player2.is_playing: 
		targets.append(player2.global_position)

	# Se pelo menos um estiver vivo, a câmera se move
	if targets.size() > 0:
		var average_pos = Vector2.ZERO
		for pos in targets:
			average_pos += pos
		average_pos /= targets.size()
		
		global_position = global_position.lerp(average_pos, smooth_speed * delta)

		if targets.size() > 1:
			var dist_x = abs(player1.global_position.x - player2.global_position.x)
			var dist_y = abs(player1.global_position.y - player2.global_position.y)
			
			var screen_size = get_viewport_rect().size
			var aspect_ratio = screen_size.x / screen_size.y
			
			var effective_distance = max(dist_x, dist_y * aspect_ratio)
			
			var target_zoom_val = map_range(effective_distance, 0, 1200, max_zoom, min_zoom)
			var target_zoom = Vector2(target_zoom_val, target_zoom_val)
			
			zoom = zoom.lerp(target_zoom, zoom_speed * delta)
		else:
			var default_zoom = Vector2(max_zoom, max_zoom)
			zoom = zoom.lerp(default_zoom, zoom_speed * delta)

func map_range(value: float, low1: float, high1: float, low2: float, high2: float) -> float:
	var res = low2 + (value - low1) * (high2 - low2) / (high1 - low1)
	return clamp(res, min(low2, high2), max(low2, high2))
