extends Area2D

export var speed : int = 300
export var lifetime : float = 0.95
export var chargeuptime : float = 0.32
export var push : int = 10

onready var direction = Vector2(cos(rotation), sin(rotation))

func _ready():
	$AnimationPlayer.play("spawn")
	$Timer.start(lifetime)

func init(color):
	$Sprite.self_modulate = color

func _physics_process(delta):
	if not $AnimationPlayer.is_playing():
		position += direction * speed * delta

func _on_Timer_timeout():
	print("on timer timeout enemy03")
	$CollisionShape2D.disabled = true
	$AnimationPlayer.play_backwards("spawn")
	
func _on_Bullet_body_entered(body):
	if body == $"../..":
		return
	
	var groups = body.get_groups()
	if groups.has("Living"):
		# Push back
		body.position += direction * push
		body.die()
	
	$CollisionShape2D.set_deferred("disabled", true)
	$AnimationPlayer.play("despawn")

func _on_AnimationPlayer_animation_finished(_anim_name):
	queue_free()