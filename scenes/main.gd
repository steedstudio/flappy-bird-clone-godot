extends Node

@export var pipes_scene: PackedScene
@export var player_scene: PackedScene
var current_score = 0

#Called when the node enters the scene tree for the first time. 
func _ready():
	get_ready()
	SaveLoad._load()

# Spawn new pipes at a fixed rate set by timer. 
func _on_pipe_spawn_timer_timeout():
	print("Pipe spawned!")
	# New pipe spawn instance.
	var pipes_spawn = pipes_scene.instantiate()
	
	#Choose a random point on pipe spawn path
	var pipe_spawn_location = $PipePath/PipeSpawnLocation
	pipe_spawn_location.progress_ratio = randf()
	pipes_spawn.position = pipe_spawn_location.position
	
	# Connect score signal to main script. 
	pipes_spawn.score.connect(_on_score_signal_received)
	add_child(pipes_spawn, true)

# Game over when player touches pipe or ground.
func _on_player_body_entered():
	print ("Game Over!")
	$PipeSpawnTimer.stop()
	var spawned_pipes = get_tree().get_nodes_in_group("pipes")
	for i in spawned_pipes:
		i.disable_collision()
	$Ground/AnimationPlayer.stop()
	if current_score > SaveLoad.contents_to_save.high_score:
		SaveLoad.contents_to_save.high_score = current_score
		SaveLoad._save()
	$HUD.game_over(current_score)


# Update current HUD score when passing through a pipe. 
func _on_score_signal_received():
	current_score += 1
	$HUD.update_score(current_score)

# Restart the game
func _on_hud_start_game():
	var player = get_tree().get_first_node_in_group("player")
	player.queue_free()
	var spawned_pipes = get_tree().get_nodes_in_group("pipes")
	for i in spawned_pipes:
		i.queue_free()
	get_ready()

# Game starts when timer expires.
func _on_get_ready_timer_timeout():
	$HUD.toggle_get_ready()
	var player = get_tree().get_first_node_in_group("player")
	player.gravity_scale = 0.75
	player.can_jump = true

# Logic for starting and restarting the game. 
func get_ready():
	$Ground/AnimationPlayer.play("move ground")
	current_score = 0
	$HUD.update_score(current_score)
	var player = player_scene.instantiate()
	player.position = $PlayerSpawnPoint.position
	player.game_over.connect(_on_player_body_entered)
	player.gravity_scale = 0
	player.can_jump = false
	add_child(player, true)
	$HUD.toggle_get_ready()
	$GetReadyTimer.start()
	$PipeSpawnTimer.start()
