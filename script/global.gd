extends Node

var score = 0
var saved_score = 0

var player1 = null
var player2 = null

var restart = false

var p2_joined = false

func _process(_delta):
	if not restart:
		check_game_over()
	
	if Input.is_action_just_pressed("p2_join"):
		if is_instance_valid(player2) and not player2.is_playing and is_instance_valid(player1):
			player2.join_game(player1.global_position)
			
			p2_joined = true
	
pass

func check_game_over():
	
	if player1 == null and player2 == null:
		return
	
	var p1_active_and_alive = false
	if is_instance_valid(player1) and player1.is_playing:
		p1_active_and_alive = player1.is_alive
	
	var p2_active_and_alive = false
	if is_instance_valid(player2) and player2.is_playing:
		p2_active_and_alive = player2.is_alive
	
	if not p1_active_and_alive and not p2_active_and_alive:
		
		restart = true
		restart_level()

func restart_level():
	
	await get_tree().create_timer(1).timeout
	
	score = saved_score
	
	player1 = null
	player2 = null
	
	get_tree().reload_current_scene()
	await get_tree().process_frame
	
	restart = false
	
