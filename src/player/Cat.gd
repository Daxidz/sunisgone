extends KinematicBody2D

onready var animationtree
var anim_state_machine

var interactibles  = []
var rng = RandomNumberGenerator.new()

export var speed = 40 

var velocity = Vector2.ZERO

var cur_anim = ""

#onready var lickTimer = $LickTimer

var can_move = true

#func start_lick_timer():
#	var time = rng.randi_range(8, 15)
#	lickTimer.start(time)

func _ready():
	rng.randomize()
#	anim_state_machine = $Sprite/AnimationTree.get("parameters/playback")
	cur_anim = "idle"
#	anim_state_machine.start(cur_anim)
#	start_lick_timer()

	
func _process(delta):
#	change_y_size()
	if Input.is_action_just_pressed("ui_accept"):
		if interactibles.size() > 0:
			print(interactibles)
			var interactible = interactibles.front()
			print(interactible)
			if (interactible.has_method("interact")):
				interactible.interact(self)
	
	if (velocity.x > 0):
		$Sprite.flip_h = true
	elif (velocity.x < 0):
		$Sprite.flip_h = false
		
	var next_anim = ""
	if velocity == Vector2.ZERO:
		next_anim = "idle"
	else:
		next_anim = "walking"
		
	
	if next_anim != "" && next_anim != cur_anim:
#		anim_state_machine.travel(next_anim)
		cur_anim = next_anim


func _physics_process(delta):
	if not can_move:
		return
	var input_direction = Vector2.ZERO
	
	input_direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	velocity = input_direction.normalized() * speed
	
	move_and_collide(velocity * delta)
	



#
#func _on_LickTimer_timeout():
#	if cur_anim == "idle":
#		var anim_idx = rng.randi_range(0, special_anims.size()-1)
#		start_lick_timer()
#		anim_state_machine.travel(special_anims[anim_idx])
