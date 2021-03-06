extends "res://scripts/Enemy.gd"

var Explosion = preload("res://scenes/ExplosionTimed.tscn")

func _on_Timer_timeout() -> void:
	match state:
		States.SHOOTING: #TODO: dorai!!
			var angle : float = target.position.angle_to_point(position) + PI
			var bullet = Bullet.instance()
			if false:
				bullet.position = get_global_transform().get_origin() - Vector2(16, 0).rotated(angle)
				bullet.rotation = angle - PI
				bullet.init(bullet_modulate)
				bullet.lifetime = attack_distance.y / float(bullet_speed) * 1.1
				bullet.speed = bullet_speed
				$Gun.add_child(bullet)
				SoundService.call(sound + "_gunshot")
			
			var explosion = Explosion.instance()
			explosion.position = target.position
			$Gun.add_child(explosion)
			print('SoundService.call(sound + "_electronic_whine")')
			
			# Muzzle flash
			if MuzzleFlash:
				var muzzle_flash = MuzzleFlash.instance()
				muzzle_flash.position = -Vector2(16, 0).rotated(angle)
				muzzle_flash.rotation = bullet.rotation
				add_child(muzzle_flash)
		_:
			._on_Timer_timeout()

