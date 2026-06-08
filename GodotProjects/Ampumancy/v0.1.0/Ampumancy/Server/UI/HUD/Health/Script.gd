extends Control

# TODO: Finish the damage decay animation stuff for health bar

var Stats: PlayerStatsData

@export_group("Font")
@onready var HealthValue: Label = $HealthMargin/BarContainer/TextMargin/CurrentHealth
@onready var Divider: Label = $HealthMargin/BarContainer/TextMargin/Divider
@onready var MaxHealthValue: Label = $HealthMargin/BarContainer/TextMargin/MaxHealth
@export var text_settings: LabelSettings
@export_category("Textures")
@export_group("Health")
@onready var HealthBar = $HealthMargin/BarContainer/HealthBar
@onready var DamageDecay = $HealthMargin/BarContainer/DamageDecay
@export var health_background: Texture2D = preload("res://Common/Textures/UI/HUD/Health/bar_bg.png")
@export var health: Texture2D = preload("res://Common/Textures/UI/HUD/Health/health_fill.png")
@export var damage_decay: Texture2D = preload("res://Common/Textures/UI/HUD/Health/damage_decay.png")
@export var health_bar_frame: Texture2D = preload("res://Common/Textures/UI/HUD/Health/bar_frame.png")
@export_group("Gilded Constitution")
@onready var GoldHealthBar = $HealthMargin/BarContainer/GoldHealthBar
@onready var GoldDamageDecay = $HealthMargin/BarContainer/GoldDamageDecay
@export var gold_health: Texture2D = preload("res://Common/Textures/UI/HUD/Health/gold_health_fill.png")
@export var gold_damage_decay: Texture2D = preload("res://Common/Textures/UI/HUD/Health/gold_damage_decay.png")
@export var gold_health_bar_frame: Texture2D = preload("res://Common/Textures/UI/HUD/Health/gold_bar_frame.png")


func _ready() -> void:
	set_fonts()
	set_textures()


func _process(_delta: float) -> void:
	if Globals.CurrentPlayer:
		
		Stats = Globals.CurrentPlayer.Data.Stats # Controls the max values of normal and gold health
		
		if HealthBar.max_value != Stats.MaxHealth:
			HealthBar.max_value = Stats.MaxHealth
		if GoldHealthBar.max_value != Stats.GoldHealthHardCap:
			GoldHealthBar.max_value = Stats.GoldHealthHardCap
		
		if HealthBar.value != Stats.Health: # Controls the progression of the health bars
			HealthBar.value = Stats.Health
			$DamageDecayDelay.start()
		if GoldHealthBar.value != Stats.GoldHealth:
			GoldHealthBar.value = Stats.GoldHealth
			$GoldDamageDecayDelay.start()
		
		if int($HealthMargin/BarContainer/TextMargin/CurrentHealth.text) != HealthBar.value + GoldHealthBar.value: # Controls the health labels' text
			$HealthMargin/BarContainer/TextMargin/CurrentHealth.text = str(int(HealthBar.value + GoldHealthBar.value))
		if int($HealthMargin/BarContainer/TextMargin/MaxHealth.text) != Stats.MaxHealth + Stats.MaxGoldHealth:
			$HealthMargin/BarContainer/TextMargin/MaxHealth.text = str(Stats.MaxHealth + Stats.MaxGoldHealth)


func set_fonts() -> void:
	var yellow_text_settings: LabelSettings = text_settings.duplicate()
	yellow_text_settings.font_color = Color.YELLOW
	HealthValue.label_settings = yellow_text_settings
	Divider.label_settings = text_settings
	MaxHealthValue.label_settings = text_settings


func set_textures() -> void:
	GoldHealthBar.texture_over = health_bar_frame
	HealthBar.texture_progress = health
	GoldHealthBar.texture_progress = gold_health
	DamageDecay.texture_progress = damage_decay
	GoldDamageDecay.texture_progress = gold_damage_decay
	HealthBar.texture_under = health_background


func full_gold_unlocked() -> void:
	GoldHealthBar.texture_over = gold_health_bar_frame


func _on_damage_decay_delay_timeout() -> void:
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(DamageDecay, "value", HealthBar.value, 0.2)


func _on_gold_damage_decay_delay_timeout() -> void:
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(GoldDamageDecay, "value", GoldHealthBar.value, 0.2)
