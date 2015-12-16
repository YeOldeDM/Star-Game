
extends Node2D
var owner
var ammo
var shot_count = 0
var fire_delay = 0
var fire_rate = 30

func _ready():
	ammo = preload('res://npcs/projectiles/laser_shot.scn')
	owner = get_parent().get_parent().get_parent()
	set_process(true)


func _process(delta):
	if fire_delay > 0:
		fire_delay -= 1



func fire(force, acceleration):
	if fire_delay <= 0:
		#make player have to press button again to shoot again
		fire_delay = fire_rate
		#fire cost
		owner.energy -= .25
		#create shot and send it off
		var shot = ammo.instance()
		#there has got to be a better way to set the position correctly
		var player_height = owner.get_child(0).get_texture().get_height()
		var weapon_size = get_node('Sprite').get_texture().get_size()
		shot.set_pos(get_global_pos() - Vector2(weapon_size.x, player_height * 0.9) - Vector2(0, weapon_size.y * .75).rotated(owner.rotate))
		shot.set_rot(owner.rotate)
		shot.direction = Vector2(cos(owner.rotate + deg2rad(90)),\
		 -sin(owner.rotate + deg2rad(90)))
		shot.acceleration = acceleration
		#sets a unique name to later be identified if needed
		shot.set_name(shot.get_name() + ' ' + str(shot_count))
		shot.owner = owner
		add_to_group('object', true)
		get_node("/root/globals").current_map.add_child(shot)
		PS2D.body_add_collision_exception(shot.get_rid(),owner.get_rid())
		shot_count += 1
		#reset counter to reuse numbers for unique name
		if shot_count >= 25:
			shot_count = 0