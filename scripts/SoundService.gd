extends Node

var loops = {
	"intro": AudioStreamPlayer.new(),
	"main_loop": AudioStreamPlayer.new(),
	"main_loop_intro": AudioStreamPlayer.new()
}

var sfx = {
	"player_gunshot": AudioStreamPlayer.new(),
	"player_death01": AudioStreamPlayer.new(),
	"player_speech01": AudioStreamPlayer.new(),
	"player_speech02": AudioStreamPlayer.new(),
	"player_speech03": AudioStreamPlayer.new(),
	"katching": AudioStreamPlayer.new(),
	"meny_click": AudioStreamPlayer.new(),
	"end_game": AudioStreamPlayer.new(),
	"weapon_hit": AudioStreamPlayer.new(),
	"enemy01_spawn01": AudioStreamPlayer.new(),
	"enemy01_spawn02": AudioStreamPlayer.new(),
	"enemy01_spawn03": AudioStreamPlayer.new(),
	"enemy01_death01": AudioStreamPlayer.new(),
	"enemy01_death02": AudioStreamPlayer.new(),
	"enemy02_speech01": AudioStreamPlayer.new(),
	"enemy02_speech02": AudioStreamPlayer.new(),
	"enemy02_speech03": AudioStreamPlayer.new(),
	"enemy02_death01": AudioStreamPlayer.new(),
	"enemy02_death02": AudioStreamPlayer.new(),
	"enemy02_death03": AudioStreamPlayer.new(),
	"enemy02_gunshot": AudioStreamPlayer.new(),
	"enemy03_spawn01": AudioStreamPlayer.new(),
	"enemy03_gunshot": AudioStreamPlayer.new(),
	"enemy03_death01": AudioStreamPlayer.new(),
	"boss01_spawn01": AudioStreamPlayer.new(),
	"boss01_spawn02": AudioStreamPlayer.new(),
	"boss01_spawn03": AudioStreamPlayer.new(),
	"boss01_gunshot": AudioStreamPlayer.new(),
	"boss01_step": AudioStreamPlayer.new(),
	"boss01_death01": AudioStreamPlayer.new(),
	"ricochet01": AudioStreamPlayer.new(),
	"small_explosion": AudioStreamPlayer.new()
}

var current_bg_music = {
#	"drums": null,
#	"koto": null,
	"music": null
}

var next_bg_music = {
#	"drums": null,
#	"koto": null,
	"music": null
}

func _ready():
	loops.intro.stream = preload("res://sounds/music/intro.wav")
	loops.main_loop.stream = preload("res://sounds/music/main_loop.wav")
	loops.main_loop_intro.stream = preload("res://sounds/music/main_loop_intro.wav")
	
	sfx.player_death01.stream = preload("res://sounds/sfx/player_death01.wav")
	sfx.player_speech01.stream = preload("res://sounds/sfx/player_speech01.wav")
	sfx.player_speech02.stream = preload("res://sounds/sfx/player_speech02.wav")
	sfx.player_speech03.stream = preload("res://sounds/sfx/player_speech03.wav")
	sfx.katching.stream = preload("res://sounds/sfx/katching!.wav")
	sfx.player_gunshot.stream = preload("res://sounds/sfx/gun01.wav")

	
	sfx.enemy01_spawn01.stream = preload("res://sounds/sfx/enemy01_spawn01.wav")
	sfx.enemy01_spawn02.stream = preload("res://sounds/sfx/enemy01_spawn02.wav")
	sfx.enemy01_spawn03.stream = preload("res://sounds/sfx/enemy01_spawn03.wav")
	sfx.enemy01_death01.stream = preload("res://sounds/sfx/enemy01_death01.wav")
	sfx.enemy01_death02.stream = preload("res://sounds/sfx/enemy01_death02.wav")
	
	sfx.enemy02_speech01.stream = preload("res://sounds/sfx/enemy02_speech01.wav")
	sfx.enemy02_speech02.stream = preload("res://sounds/sfx/enemy02_speech02.wav")
	sfx.enemy02_speech03.stream = preload("res://sounds/sfx/enemy02_speech03.wav")
	sfx.enemy02_gunshot.stream = preload("res://sounds/sfx/gun02.wav")
	sfx.enemy02_death01.stream = preload("res://sounds/sfx/enemy02_death01.wav")
	sfx.enemy02_death02.stream = preload("res://sounds/sfx/enemy02_death02.wav")
	sfx.enemy02_death03.stream = preload("res://sounds/sfx/enemy02_death03.wav")
	
	#tmp
	sfx.enemy03_spawn01.stream = preload("res://sounds/sfx/enemy02_speech01.wav")
	sfx.enemy03_gunshot.stream = preload("res://sounds/sfx/enemy02_speech01.wav")
	sfx.enemy03_death01.stream = preload("res://sounds/sfx/enemy02_speech01.wav")
	
	#TODO:
#	sfx.enemy03_spawn01 = preload("res://sounds/sfx/enemy03_spawn01.wav")
#	sfx.enemy03_gunshot = preload("res://sounds/sfx/enemy03_gunshot01.wav")
#	sfx.enemy03_death01 = preload("res://sounds/sfx/enemy03_death01.wav")
	
	sfx.boss01_spawn01.stream = preload("res://sounds/sfx/boss01_spawn01.wav")
	sfx.boss01_spawn02.stream = preload("res://sounds/sfx/boss01_spawn02.wav")
	sfx.boss01_spawn03.stream = preload("res://sounds/sfx/boss01_spawn03.wav")
	sfx.boss01_gunshot.stream = preload("res://sounds/sfx/boss01_gun01.wav")
	sfx.boss01_step.stream = preload("res://sounds/sfx/boss01_step.wav")
	sfx.boss01_death01.stream = preload("res://sounds/sfx/boss01_death01.wav")
	
	sfx.ricochet01.stream = preload("res://sounds/sfx/ricochet01.wav")
	sfx.small_explosion.stream = preload("res://sounds/sfx/boss01_death01.wav")
	
	for key in loops:
		add_child(loops[key])
		loops[key].connect("finished", self, "_on_sound_finished")
		loops[key].set_bus("Music")
		
	for key in sfx:
		add_child(sfx[key])
		if "enemy" in key:
			sfx[key].set_bus("Enemy")
		if "spawn" in key:
			sfx[key].set_bus("Spawn")
		if "enemy02_speech" in key or "enemy02_death" in key:
			sfx[key].set_bus("Speech")
		if "boss01_spawn" in key or "boss01_death" in key:
			sfx[key].set_bus("Music") #this might be controversial, wanna find other soln
	sfx.ricochet01.set_bus("Player")

func stop_all_music():
	for key in loops:
		if loops[key] != null:
			loops[key].stop()
	for key in current_bg_music:
		current_bg_music[key] = null
		next_bg_music[key] = null

func _on_sound_finished():
	for key in next_bg_music:
		if next_bg_music[key] != null:
			current_bg_music[key] = next_bg_music[key]
	for key in current_bg_music:
		if current_bg_music[key] != null:
			current_bg_music[key].play()
#	if(next_bg_music != null):
#		current_bg_music = next_bg_music
#	current_bg_music.play()
	pass

func play_or_queue(loops):
	var all_are_null = true
	var at_least_one_is_null = false
	for key in loops:
		if current_bg_music[key] == null:
			current_bg_music[key] = loops[key]
			at_least_one_is_null = true
		else:
			all_are_null = false
#	print("all_are_null ", all_are_null, "; at_least_one_is_null ", at_least_one_is_null)
	if all_are_null:
		for key in current_bg_music:
			if current_bg_music[key] != null:
				current_bg_music[key].play()
				#print("bus ", current_bg_music[key].get_bus() )
	elif at_least_one_is_null:
		pass
	for key in loops:
		next_bg_music[key] = loops[key]

func main_menu():
	var loopses = {
		"music":loops.intro
		}
	play_or_queue(loopses)

func game_start():
	var loopses = {"music":loops.main_loop_intro}
	play_or_queue(loopses)

func game():
	var loopses = {"music":loops.main_loop}
	play_or_queue(loopses)

func death_scene_transition():
	sfx.death_scene_transition.play()
	pass

func enemy01_spawn():
	var index = randi() % 3 + 1
	var key_string = str("enemy01_spawn0", index)
	sfx[key_string].pitch_scale = randf() * 0.4 + 0.8
	sfx[key_string].play()
	pass

func enemy01_death():
	var index = randi() % 2 + 1
	var key_string = str("enemy01_death0", index)
	sfx[key_string].pitch_scale = randf() * 0.4 + 1.2
	sfx[key_string].play()
	pass

func enemy02_spawn():
	var index = randi() % 3 + 1
	var key_string = str("enemy02_speech0", index)
	sfx[key_string].pitch_scale = randf() * 0.4 + 0.8
	sfx[key_string].play()
	pass

func enemy02_speech():
	var index = randi() % 2 + 1
	var key_string = str("enemy02_speech0", index)
	sfx[key_string].pitch_scale = randf() * 0.4 + 0.8
	sfx[key_string].play()
	pass

func enemy02_gunshot():
	sfx.enemy02_gunshot.pitch_scale = randf() * 0.8 + 0.8
	sfx.enemy02_gunshot.play()

func enemy02_death():
	var index = randi() % 2 + 1
	var key_string = str("enemy02_death0", index)
	sfx[key_string].pitch_scale = randf() * 0.4 + 1.2
	sfx[key_string].play()
	pass

func enemy03_spawn():
	print("enemy03 spawn sound")
	pass

func enemy03_hit():
	fleshthump()

func enemy03_gunshot():
	print("enemy03 gunshot sound")

func enemy03_death():
	print("enemy03 death sound")

func enemy04_spawn():
	print("enemy04 spawn sound")
	pass

func enemy04_hit():
	fleshthump()

func enemy04_death():
	print("enemy04 death sound")

func boss01_spawn():
	var index = randi() % 3 + 1
	var key_string = str("boss01_spawn0", index)
	sfx[key_string].pitch_scale = randf() * 0.6 + 0.4
	sfx[key_string].play()
	pass

func boss01_step():
	var key_string = "boss01_step"
	sfx[key_string].pitch_scale = randf() * 0.4 + 1.2
	sfx[key_string].play()
	pass

func boss01_gunshot():
	sfx.boss01_gunshot.pitch_scale = randf() * 0.8 + 0.8
	sfx.boss01_gunshot.play()

func boss01_hit():
	ricochet()

func boss01_death():
	var index = 1
	var key_string = str("boss01_death0", index)
	sfx[key_string].pitch_scale = randf() * 0.4 + 1.2
	sfx[key_string].play()
	pass

func player_gunshot():
	sfx.player_gunshot.pitch_scale = randf() * 0.8 + 0.8
	sfx.player_gunshot.play()

func ricochet():
	sfx.ricochet01.pitch_scale = randf() * 0.8 + 0.8
	sfx.ricochet01.play()

func small_explosion():
	sfx.small_explosion.pitch_scale = randf() * 0.8 + 0.8
	sfx.small_explosion.play()

func fleshthump():
	print("fleshy sound")
	return

func katching():
	sfx.katching.pitch_scale = randf() * 0.8 + 0.8
	sfx.katching.play()

func player_death():
	var num_player_death = 0
	for key in sfx:
		if "player_death" in key:
			num_player_death += 1
	var index = randi() % num_player_death + 1
	var key_string = str("player_death0", index)
	sfx[key_string].pitch_scale = randf() * 0.6 + 0.8
	sfx[key_string].play()

func player_speech():
	var index = randi() % 3 + 1
	var key_string = str("player_speech0", index)
	sfx[key_string].pitch_scale = randf() * 0.4 + 0.8
	sfx[key_string].play()
	

func click():
	sfx.click.play()

func weapon_crit():
	sfx.weapon_crit.play()
	
func weapon_hit():
	sfx.weapon_hit.play()

func endgame():
	sfx.endgame.play()