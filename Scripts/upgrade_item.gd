extends PanelContainer

@export var upgrade_name : String = "Upgrade"
@export_multiline var description: String = "description"

#Cost Managment
@export var base_cost_gold : int = 0
@export var base_cost_scrap : int = 0
@export var base_cost_food : int = 0

@export var cost_growth : float = 1.5
@export var upgrade_id : String = ""

var current_level : int = 0

@onready var title_label: Label = $TextureRect/VBoxContainer/TitleLabel
@onready var cost_label: Label = $TextureRect/VBoxContainer/CostLabel
@onready var buy_button: Button = $TextureRect/VBoxContainer/BuyButton

func _ready() -> void:
	update_ui()
	GameManager.gold_changed.connect(_on_resources_changed)
	GameManager.scrap_changed.connect(_on_resources_changed)
	GameManager.food_changed.connect(_on_resources_changed)
	


func _on_buy_button_pressed() -> void:
	var gold_cost = get_current_cost(base_cost_gold)
	var scrap_cost = get_current_cost(base_cost_scrap)
	var food_cost = get_current_cost(base_cost_food)
	
	if GameManager.can_afford(gold_cost, scrap_cost, food_cost):
		GameManager.spend_resources(gold_cost, scrap_cost, food_cost)
		apply_upgrade()
		update_ui()
		
func apply_upgrade():
	current_level += 1
	match upgrade_id:
		
		"Pocket Search":
			if current_level > 1:
				GameManager.gold_drop_multiplier += 0.5
			else:
				GameManager.gold_drop_multiplier += 1
		
		"Scavengers":
			GameManager.auto_scavange = true
			if current_level > 1:
				GameManager.auto_scrap_amount *= 1.25
			
		"Farmers":
			GameManager.auto_farm = true
			if current_level > 1:
				GameManager.auto_food_amount *= 1.25
			
		"Strenght":
			GameManager.click_damage += 1
		
		"Storeroom_Unlocked":
			GameManager.storeroom_unlocked = true
			if current_level > 1:
				GameManager.scrap_per_scavange *= 1.25
			
		"Farm_Unlocked":
			GameManager.farm_unlocked = true
			if current_level > 1:
				GameManager.food_per_harvest *= 1.25
		
		"Gear":
			GameManager.arrow_damage += 0.25
		
		"Arrow_count":
			GameManager.arrow_count = min(GameManager.arrow_count +1, 3)
			
		"Archers":
			GameManager.archer_count += 1
			get_tree().current_scene.find_child("Game").spawn_archer()
		
	print("Upgraded ", upgrade_id, " to level ", current_level)

func get_current_cost(base : int) -> int:
	if base == 0: return 0
	return GameManager.get_upgrade_cost(base, current_level, cost_growth)
	
func update_ui():
	var gold_cost = get_current_cost(base_cost_gold)
	var scrap_cost = get_current_cost(base_cost_scrap)
	var food_cost = get_current_cost(base_cost_food)
	
	title_label.text = "%s (Lvl %d)" % [upgrade_name, current_level]
	
	var cost_text = ""
	if gold_cost > 0 : cost_text += "Gold: %d " %gold_cost
	if scrap_cost > 0 : cost_text += "scrap: %d " %scrap_cost
	if food_cost > 0 : cost_text += "food: %d " %food_cost
	
	if cost_text == "": cost_text = "Maxed"
	
	cost_label.text = cost_text
	_on_resources_changed(0)
	
func _on_resources_changed(_amount):
	var gold_cost = get_current_cost(base_cost_gold)
	var scrap_cost = get_current_cost(base_cost_scrap)
	var food_cost = get_current_cost(base_cost_food)
	
	buy_button.disabled = not GameManager.can_afford(gold_cost, scrap_cost, food_cost)
	
	
