extends Attractor

@export var damage: int
@export var speed: float
var initVelocity = Vector2(-500,0)
# Called when the node enters the scene tree for the first time.
func _ready():
	$SpawnTimer.start()
	apply_impulse(initVelocity)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_spawn_timer_timeout():
	set_collision_mask_value(1, true)
	pass # Replace with function body.


func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	pass # Replace with function body.


func _on_body_entered(body):
	print("ow")
	if(body.is_in_group("Damageable")):
		body.takeDamage(damage)
		if($FireSound.playing):
			$FireSound.stop()
		$ImpactDamageableSound.play()
		queue_free()
	else:
		if($FireSound.playing):
			$FireSound.stop()
		$ImpactWallSound.play()
		queue_free()
	pass # Replace with function body.
