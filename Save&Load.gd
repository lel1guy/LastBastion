extends Node


const save_location = "user://SaveFile.json"
func save_game():
	GameManager.last_saved_time = Time.get_unix_time_from_system()
	
	var contents_to_save : Dictionary = {
		"last_saved_time" : GameManager.last_saved_time,
		"gold" : GameManager.gold,
		"food" : GameManager.food,
		"scrap" : GameManager.scrap,
		"storeroom_unlocked" : GameManager.storeroom_unlocked,
		"farm_unlocked" : GameManager.farm_unlocked,
		"click_damage" : GameManager.click_damage,
		"arrow_damage" : GameManager.arrow_damage,
		"arrow_count" : GameManager.arrow_count,
		"archer_count" : GameManager.archer_count,
		"auto_farm" : GameManager.auto_farm,
		"auto_scavange" : GameManager.auto_scavange,
		"gold_drop_multiplier" : GameManager.gold_drop_multiplier,
		"auto_scrap_amount" : GameManager.auto_scrap_amount,
		"auto_food_amount" : GameManager.auto_food_amount,
		"scrap_per_scavange" : GameManager.scrap_per_scavange,
		"food_per_harvest" : GameManager.food_per_harvest,
		"upgrade_level" : GameManager.upgrade_level
	}
	
	var file = FileAccess.open(save_location, FileAccess.WRITE)
	var json_string = JSON.stringify(contents_to_save)
	file.store_string(json_string)
	
	print("Game Saved Successfully!")
	
func load_game():
	if not FileAccess.file_exists(save_location):
		print("No Save, Making one!")
		return
	
	var file = FileAccess.open(save_location, FileAccess.READ)
	var json_string = file.get_as_text()
	
	var json = JSON.new()
	var error = json.parse(json_string)
	
	if error == OK:
		var data = json.data
		
		GameManager.last_saved_time = data.get("last_saved_time", Time.get_unix_time_from_system())
		
		GameManager.gold = data.get("gold", 500)
		GameManager.food = data.get("food", 500)
		GameManager.scrap = data.get("scrap", 500)
		GameManager.storeroom_unlocked = data.get("storeroom_unlocked", false)
		GameManager.farm_unlocked = data.get("farm_unlocked", false)
		GameManager.click_damage = data.get("click_damage", 1)
		GameManager.arrow_damage = data.get("arrow_damage", 0.25)
		GameManager.arrow_count = data.get("arrow_count", 1)
		GameManager.archer_count = data.get("archer_count", 0)
		GameManager.auto_farm = data.get("auto_farm", false)
		GameManager.auto_scavange = data.get("auto_scavange", false)
		GameManager.gold_drop_multiplier = data.get("gold_drop_multiplier", 1.0)
		GameManager.auto_food_amount = data.get("auto_food_amount", 1)
		GameManager.auto_scrap_amount = data.get("auto_scrap_amount", 1)
		GameManager.scrap_per_scavange = data.get("scrap_per_scavange", 10)
		GameManager.food_per_harvest = data.get("food_per_harvest", 5)
		GameManager.upgrade_level = data.get("upgrade_level", {})
		GameManager.gold_changed.emit(GameManager.gold)
		GameManager.scrap_changed.emit(GameManager.scrap)
		GameManager.food_changed.emit(GameManager.food)
		
		print("Game Loaded!")
	else:
		print("Game Load Failed, JSON Parse Error.") 
		
func _ready() -> void:
	var auto_save_timer = Timer.new()
	auto_save_timer.wait_time = 60.0
	auto_save_timer.autostart = true
	auto_save_timer.timeout.connect(save_game)
	add_child(auto_save_timer)
