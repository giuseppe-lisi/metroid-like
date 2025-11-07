extends CharacterBody2D

var direction_x: float
var speed: int = 50
@export var jump_strenght := 10
@export var gravity := 10
signal shoot(pos: Vector2, dir: Vector2)

func get_input():
	direction_x = Input.get_axis("left","right")
	if Input.is_action_just_pressed("jump"):
		velocity.y = -jump_strenght

func apply_gravity(delta):
	velocity.y += gravity * delta

func shooting():
	if Input.is_action_just_pressed("shoot") and $ReloadTimer.time_left == 0:
		$ReloadTimer.start()
		shoot.emit(position, get_local_mouse_position().normalized())

func _physics_process(delta: float) -> void:
	get_input()
	apply_gravity(delta)
	shooting()
	velocity.x = direction_x * speed
	move_and_slide()
	animation()

func animation():
	$Legs.flip_h = direction_x < 0
	$AnimationPlayer.current_animation = "run_animation" if direction_x else "idle"
