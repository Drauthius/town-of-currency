extends "res://scripts/Enemy.gd"

func _play_sound(clip):
	SoundService.call(sound + "_" + clip)