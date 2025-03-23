extends Node

var main: Level
var window_size: Vector2 = Vector2(1920, 1080)
var master_volume: int = 100
var music_volume: int = 25
var sfx_volume: int = 80

var spell_lib: SpellLibrary = SpellLibrary
var sigbus: SignalBus = SignalBus
var util: Utility = Utility
var refs: References = References
