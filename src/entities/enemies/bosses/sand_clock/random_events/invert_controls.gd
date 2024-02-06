extends Node


func _enabled():
	var player = Core.get_player()
	player.walk_speed = -player.walk_speed


func _disabled():
	var player = Core.get_player()
	player.walk_speed = abs(player.walk_speed)
