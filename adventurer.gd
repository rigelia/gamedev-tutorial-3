extends CharacterBody2D


@export var speed = 200
@export var gravity = 200.0
@export var jump_speed = -300
@onready var sprite = $AnimatedSprite2D
var JUMP_QUOTA = true

func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		sprite.stop()
		velocity.y += gravity * delta
		if velocity.y > 0:
			sprite.play("fall")
		
	if is_on_floor() and velocity.x == 0:
		JUMP_QUOTA = true
		sprite.play("idle")
		
	# Handle jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = jump_speed
		sprite.play("jump")
	if Input.is_action_just_pressed("ui_up") and not is_on_floor() and JUMP_QUOTA==true:
		velocity.y = jump_speed+100
		sprite.play("jump_2")
		JUMP_QUOTA = false

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if Input.is_action_pressed("ui_left"):
		velocity.x = -speed
		sprite.flip_h = true
		if is_on_floor():
			sprite.play("walk")
	elif Input.is_action_pressed("ui_right"):    
		velocity.x = speed
		sprite.flip_h = false
		if is_on_floor():
			sprite.play("walk")
		
	else:
		velocity.x = 0

	move_and_slide()
