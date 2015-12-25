

extends 'res://ships/ship.gd'

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	name = 'terran_corvette'
	race = 'terran'
	size = 1
	size_name = 'medium'
	variation = 2
	variation_name = 'offensive'
	status = preload('res://ships/terran_corvette/terran_corvette_status.scn').instance()
#	get_node('/client/gui/status_control/status_bg/status_holder').add_child(status.instance())
	cargo = preload('res://ships/medium_normal_inventory.scn').instance()
#	get_node('/client/gui/inventory_control/items_bg/cargo_holder').add_child(cargo.instance())
	weapons['medium_laser'] = preload('res://ships/equipment/laser_cannon.scn').instance()
	self.get_node('hull/main_cannon').add_child(weapons.medium_laser)
	current_weapon = weapons.medium_laser
	previous_pos = get_pos()
	current_pos = get_pos()
	get_node("/root/globals").player_scale = get_node("Camera2D").get_zoom()
	burners.append(get_node('hull/burner_left'))
	burners.append(get_node('hull/burner_right'))
	owner = 'player'
	shield_index = get_node("shield_shape").get_collision_object_shape_index()
	shield_size = get_shape_transform(shield_index)
	shape_hit = get_shape(0)
	add_child(controls)
	max_health = status.core_get() * 50
	max_energy = status.engineering_get() * 50
	health = max_health
	energy = max_energy
	shield_strength = ceil((status.weapons_get() + status.core_get()) / 2) * 5
	pass


