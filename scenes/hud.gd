extends CanvasLayer

signal start_game

# Update the visible score label.
func update_score(score):
    $ScoreLabel.text = str(score)

# Make game over HUD visible and update final score.
func game_over(score):
    $ScoreBox/EndScoreLabel.text = str(score)
    $ScoreBox/HighScoreLabel.text = str(SaveLoad.contents_to_save.high_score)
    $GameOver.visible = true
    $ScoreBox.visible = true
    $ScoreBox/EndScoreLabel.visible = true
    $ScoreBox/HighScoreLabel.visible = true
    $StartButton.visible = true

# Used to show/hide get ready graphic. 
func toggle_get_ready():
    $GetReady.visible = !$GetReady.visible
    print("Get ready function called!")

# Hide HUD items when new game is started.
func _on_start_button_pressed():
    print("start button pressed!")
    start_game.emit()
    $GameOver.visible = false
    $ScoreBox.visible = false
    $ScoreBox/EndScoreLabel.visible = false
    $StartButton.visible = false
