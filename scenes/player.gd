extends RigidBody2D

@export var jump_force = -150
var can_jump: bool = true
var first_collision: bool = false
signal game_over

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
    # jumping code
    if Input.is_action_just_pressed("jump") and can_jump:
        linear_velocity.y = jump_force

#func _integrate_forces(state):
    #if Input.is_action_just_pressed("jump") and can_jump:
        #state.apply_central_force(jump_force)
        #print("jump!")


func _on_body_entered(_body):
    if first_collision == false:
        can_jump = false
        first_collision = true
        game_over.emit()
