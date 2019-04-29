extends KinematicBody2D

const QPI = PI/4.0

export var normal_speed = 50
export var shooting_distance = 500
export var evasion_distance = 150
export var bullet_speed = 180
var shooting_distance_sqrd = shooting_distance*shooting_distance
var evasion_distance_sqrd = evasion_distance*evasion_distance
#export var max_speed = 400
export var cornered_distance = 20
export var bounds = Vector2(1024, 600)

export var time_until_removal = 4
export var time_until_next_shot = 0.8
var death_timer = 0.0
var shooting_timer = 0.0
var is_dead = false

signal death

var behaviour_timer = 0.0
export var timer_long = 2.0
export var timer_short = 0.2
var angle = 0.0

enum {PURSUE, SHOOT, COUNTER, EVADE, RIGHT, LEFT} 
var behaviour_state = PURSUE
var rand_direction = RIGHT

onready var player = $"../Player"

onready var Bullet = preload("res://scenes/BulletBig.tscn")
onready var MuzzleFlash = preload("res://scenes/MuzzleFlash.tscn")
onready var SoundService = $"/root/SoundService"

func _ready():
	SoundService.enemy02_spawn()

func _physics_process(delta):
	if is_dead:
		death_timer += delta
		if death_timer > time_until_removal:
			queue_free()
		return
	
	var player_distance_sqrd = position.distance_squared_to(player.position)
	angle = (-position + player.position).angle() + PI
	
	if false and behaviour_state == PURSUE:
		if player_distance_sqrd < shooting_distance_sqrd:
			behaviour_state = SHOOT
		pass
	
	var current_speed = normal_speed
	var direction = (player.position - position).normalized()
	
	#movement handling
	if behaviour_state != SHOOT:
		var _velocity = move_and_slide(direction * current_speed, Vector2(0, 0), true, 1, 0.0, false)
		if angle > 5*QPI and angle < 7*QPI:
			$AnimationPlayer.play("down_run")
		elif angle > 3*QPI and angle < 5*QPI:
			$AnimationPlayer.play("right_run")
		elif angle > QPI and angle < 3*QPI:
			$AnimationPlayer.play("up_run")
		else:
			$AnimationPlayer.play("left_run")
	
	#handle shooting
	if behaviour_state == SHOOT:
		pass




