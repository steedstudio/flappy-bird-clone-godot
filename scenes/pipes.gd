extends StaticBody2D

@export var speed = 55
var move_left = Vector2(-1,0)
signal score

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += move_left * speed * delta

# Deletes pipes when they go offscreen.
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

# Disables pipe collision and stops pipes from moving. 
func disable_collision():
	$CollisionShape2D.set_deferred("disabled", true)
	$CollisionShape2D2.set_deferred("disabled", true)
	move_left = Vector2.ZERO

# Enables pipe collision.
func enable_collision():
	$CollisionShape2D.set_deferred("disabled", false)
	$CollisionShape2D2.set_deferred("disabled", false)


func _on_score_area_body_entered(_body):
	$ScoreArea/ScoreCollision.set_deferred("disabled", true)
	score.emit()
