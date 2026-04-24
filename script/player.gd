extends CharacterBody2D

@export var player_prefix: String = "p1"
@export var character_skin: SpriteFrames
@export var starts_active = true

var is_playing = true

var speed = 160.0
var jump_velocity = -300.0

var dir

var gravity = 980

var extra_jump = 1

@onready var anim = $AnimatedSprite2D
@onready var death_line = $"../DeathLine"

var is_alive = true

func _ready() -> void:
	
	if character_skin:
		anim.sprite_frames = character_skin
	
	anim.play("idle")
	
	if player_prefix == "p1":
		Global.player1 = self
	elif player_prefix =="p2":
		Global.player2 = self
	
	if Global.p2_joined == true:
		starts_active = true
	
	if not starts_active:
		is_playing = false
		hide()
		process_mode = Node.PROCESS_MODE_DISABLED
		$"../Player2/CollisionShape2D".set_deferred("disabled", true)
	else:
		is_playing = true
	
	pass


func _physics_process(delta: float) -> void:
	
	move(delta)
	
	if is_alive:
		animations()
	
	
	pass


func move(delta):
	
	if is_alive:
		dir = Input.get_axis(player_prefix + "_left",player_prefix + "_right")
	
	if dir: 
		velocity.x = dir * speed
	elif dir == 0:
		velocity.x = 0
	
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if Input.is_action_just_pressed(player_prefix + "_jump") and extra_jump > 0 and is_alive:
		velocity.y = jump_velocity
		extra_jump -= 1
		
	if is_on_floor():
		extra_jump = 1
	
	if global_position.y >= death_line.global_position.y and is_alive:
		die()
	
	
	move_and_slide()
	
	
	
	pass


func animations():
	
	if velocity.x != 0 and is_on_floor():
		anim.play("run")
	elif velocity.x == 0 and is_on_floor():
		anim.play("idle")
	
	if not is_on_floor() and extra_jump >= 1:
		anim.play("jump")
	
	if dir > 0:
		anim.flip_h = false
	elif dir < 0 :
		anim.flip_h = true
	
	
	pass
	
	
func die():
	
	is_alive=false
	anim.play("hit")
	
	$Area2D.queue_free()
	$CollisionShape2D.queue_free()
	
	velocity.y = jump_velocity - 100
	
	await get_tree().create_timer(1).timeout
	
	#get_tree().reload_current_scene()
	
	pass
	
func join_game(spawn_pos: Vector2):
	
	global_position = spawn_pos
	is_playing = true
	show()
	process_mode = Node.PROCESS_MODE_INHERIT
	$"../Player2/CollisionShape2D".set_deferred("disabled", false)

pass
