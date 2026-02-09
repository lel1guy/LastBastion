extends CanvasLayer

@onready var gold_label: Label = $GoldLabel
@onready var scrap_label: Label = $ScrapLabel
@onready var food_label: Label = $FoodLabel

func _ready() -> void:
	GameManager.gold_changed.connect(_on_gold_changed)
	_on_gold_changed(GameManager.gold)
	GameManager.scrap_changed.connect(_on_scrap_changed)
	_on_scrap_changed(GameManager.scrap)
	GameManager.food_changed.connect(_on_food_changed)
	_on_food_changed(GameManager.food)

func _on_gold_changed(amount: int) -> void:
	gold_label.text = ": " + str(amount)

func _on_scrap_changed(amount: int) -> void:
	scrap_label.text = ": " + str(amount)

func _on_food_changed(amount: int) -> void:
	food_label.text = ": " + str(amount)
