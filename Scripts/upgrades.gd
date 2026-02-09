extends Control
#singal
signal upgrade_menu_close
@onready var resources: CanvasLayer = $Resources



func _ready() -> void:
	visible = false
	resources.visible = true
	

func _on_back_button_pressed() -> void:
	upgrade_menu_close.emit()
