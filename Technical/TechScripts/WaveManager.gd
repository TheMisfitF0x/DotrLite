extends Node
# For every wave,
# 0: Enemies to spawn per wave, 1: Enemies to live at once per wave, 2: Spawn interval in seconds
var waveInformation = [
	[5, 3, 2],
	[10, 5, 1.75],
	[15, 8, 1.5],
	[20, 10, 1.25]]

var currentWave = 0
var enemiesKilled = 0
var waveStartTime
var timeAtLastSpawn

func _ready():
	waveStartTime = Time.get_ticks_msec()
	timeAtLastSpawn = Time.get_ticks_msec()

func _onDeath():
	enemiesKilled += 1
	if(enemiesKilled == waveInformation[currentWave][0]):
		if(currentWave == 3):
			pass
			#End Game
		else:
			currentWave += 1
			waveStartTime = Time.get_ticks_msec()
			
func _process(delta):
	if(Time.get_ticks_msec() > timeAtLastSpawn + waveInformation[currentWave][2]):
		get_node("/root/Game/GameplayManager").spawn(waveInformation[currentWave][1])
		timeAtLastSpawn = Time.get_ticks_msec()
