extends CharacterBody2D

@export var health: int
@export var speed = 400

var bulletRes = preload("res://Technical/Prefabs/Bullet/Bullet.tscn")

signal shoot(bullet, direction, location)

func get_input():
	var input_direction = Input.get_vector("player_left", "player_right", "player_up", "player_down")
	velocity = input_direction * speed
	
	if(Input.is_action_just_pressed("player_fire")):
		fire_bullet()

func _physics_process(delta):
	get_input()
	$Sprite2D.rotation = get_global_mouse_position().angle_to_point(position)
	move_and_slide()

func fire_bullet():
	shoot.emit(bulletRes, $Sprite2D.rotation, position)
	#play sound
	#play particle?
	
func takeDamage(damage2Take):
	health -= damage2Take
	if(health <= 0):
		queue_free()
