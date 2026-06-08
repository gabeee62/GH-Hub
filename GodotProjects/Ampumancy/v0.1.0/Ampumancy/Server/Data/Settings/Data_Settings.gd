extends Resource
class_name SettingsData

var ColdStart: bool = true
@export var FirstLaunch: bool = true

@export var Audio: AudioSettings = AudioSettings.new()
@export var Gameplay: GameplaySettings = GameplaySettings.new()
@export var Video: VideoSettings = VideoSettings.new()
