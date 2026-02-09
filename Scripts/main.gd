extends Node

@onready var game: Node2D = $Game
@onready var upgrade_menu: Control = $UI_Layer/UpgradeMenu



func _ready() -> void:
	game.upgrade_menu_open.connect(_on_open_upgrades_menu)
	upgrade_menu.upgrade_menu_close.connect(_on_close_upgrade_menu)
	_on_close_upgrade_menu()
	

func _on_open_upgrades_menu():
	upgrade_menu.visible = true
	game.visible = false


func _on_close_upgrade_menu():
	upgrade_menu.visible = false
	game.visible = true
