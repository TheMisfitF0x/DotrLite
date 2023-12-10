extends CharacterBody2D
class_name Enemy

@export var health: int
@export var speed = 3

var maxHealth
var bulletRes = preload("res://Technical/Prefabs/Bullet/Bullet.tscn")

var player
var moving = true

var spaceMovingTo
var startedMovingTime

signal shoot(bullet, direction, location)
signal death()

# Called when the node enters the scene tree for the first time.
func _ready():
	maxHealth = health
	$Control/HealthLabel.text = str(health) + "/" + str(maxHealth)
	shoot.connect(get_node("/root/Game/GameplayManager")._on_player_shoot)
	shoot.connect(get_node("/root/Game/WaveManager")._onDeath)
	player = get_node("/root/Game/Player")
	spaceMovingTo = Vector2(randf_range(-760, 760),randf_range(-740, 740))
	print(spaceMovingTo)
	startedMovingTime = Time.get_ticks_msec()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	$Sprite2D.transform = $Sprite2D.transform.looking_at(player.position)
	if(moving):
		position = position.move_toward(spaceMovingTo, speed)
	else:
		fire_bullet()
		if(position.distance_to(player.position) < 50):
			spaceMovingTo = Vector2(randf_range(-760, 760),randf_range(-740, 740))
		else:
			spaceMovingTo = player.position
		moving = true
		startedMovingTime = Time.get_ticks_msec()
	
	if(Time.get_ticks_msec() > startedMovingTime + 5000):
		moving = false

func fire_bullet():
	shoot.emit(bulletRes, $Sprite2D.rotation + randf_range(-15, 15), position)
	#play sound
	
func takeDamage(damage2Take):
	health -= damage2Take
	if(health <= 0):
		death.emit()
		queue_free()
	else:
		$Control/HealthLabel.text = str(health) + "/" + str(maxHealth)
