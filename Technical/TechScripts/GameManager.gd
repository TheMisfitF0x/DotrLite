extends Node

var enemy = preload("res://Technical/Prefabs/Enemy/Enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_shoot(bullet, direction, location):
	var spawned_bullet = bullet.instantiate()
	
	spawned_bullet.rotation = direction
	spawned_bullet.position = location
	spawned_bullet.initVelocity = spawned_bullet.initVelocity.rotated(direction)
	spawned_bullet.apply_force(spawned_bullet.initVelocity)
	add_child(spawned_bullet)
	pass # Replace with function body.

func spawn(maxLiving):
	var spawners = get_node("/root/Game/Spawners")
	if(get_tree().get_nodes_in_group("Enemy").size() < maxLiving):
		var newEnemy = enemy.instantiate()
		newEnemy.transform = spawners.get_child(randi_range(0, 7)).transform
		add_child(newEnemy)
	
	#Get a random child and instantiate a new enemy at that location
