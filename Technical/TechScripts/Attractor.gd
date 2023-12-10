extends RigidBody2D
class_name Attractor

#To prevent static attractors from receiving force calls that otherwise would do nothing.
@export var ignoreAttractions : bool

#To prevent bullets from attracting other bullets unless desired
@export var attractsBullets : bool



const G = 250

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


func _physics_process(delta):
	var attractors = []
	
	attractors = get_tree().get_nodes_in_group("Attractor")
	
	for attractor in attractors:
		if(attractor != self && !attractor.ignoreAttractions):
			if((attractsBullets && attractor.is_in_group("Bullet")) || !attractor.is_in_group("Bullet")):
				Attract(attractor)
			pass
		pass
		
	rotation = atan2(linear_velocity.y, linear_velocity.x)
	pass

func Attract(objToAttract: Attractor):
	
	var body2Attract = objToAttract
	var direction = position.direction_to(body2Attract.position)
	var distance = position.distance_to(body2Attract.position)
	var forceMagnitude = -1 * (G * (mass * body2Attract.mass) / distance)
	
	var force = direction * forceMagnitude
	
	body2Attract.apply_force(force)
	pass

