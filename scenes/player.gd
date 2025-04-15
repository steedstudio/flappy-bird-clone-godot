extends RigidBody2D

@export var jump_force = 150
var can_jump: bool = true
signal game_over

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	# jumping code
	if Input.is_action_just_pressed("jump") and can_jump:
		linear_velocity.y = 0 - jump_force


func _on_body_entered(_body):
	can_jump = false
	game_over.emit()
