extends Node


const save_location = "user://SaveFile.json"

var contents_to_save : Dictionary = {
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
	""
}
