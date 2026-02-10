extends Node
#AutoLoad Script
#Signals
signal gold_changed(amount: int)
signal food_changed(amount: int)
signal scrap_changed(amount: int)

#Resources
var gold: int = 500
var scrap: int = 500
var food: int = 500

#resource Management
func add_gold(amount: int):
	gold += amount
	gold_changed.emit(gold)

func add_scrap(amount: int):
	if storeroom_unlocked:
		scrap += amount
		scrap_changed.emit(scrap)
	
func add_food(amount: int):
	if farm_unlocked:
		food += amount
		food_changed.emit(food)

func spend_resources(cost_gold: int, cost_scrap: int, cost_food: int):
	if cost_gold > 0:
		gold -= cost_gold
		gold_changed.emit(gold)
	
	if cost_scrap > 0:
		scrap -= cost_scrap
		scrap_changed.emit(scrap)
	
	if cost_food > 0:
		food -= cost_food
		food_changed.emit(food)

func can_afford(cost_gold: int, cost_scrap: int, cost_food: int) -> bool:
	return gold >= cost_gold and scrap >= cost_scrap and food >= cost_food
	
func get_upgrade_cost(base_cost : int, level : int, growth : float) -> int:
	if base_cost == 0: return 0
	return int(base_cost * pow(growth, level))


#Unlock Flags
var storeroom_unlocked : bool = false
var farm_unlocked : bool = false

# Combat Managment
var click_damage : int = 1
var arrow_damage : float = 0.25
var arrow_count : int = 1
var gold_drop_multiplier : float = 1.0
var archer_count : int = 0
var max_archer_count : int = 4

# Mob Progression
# 0=skeleton, 1=Zombies, 2=orcs, 3=demons
var unlocked_stage : int = 0

# Economy Stats
#Scrap
var scavange_time : float = 15
var scrap_per_scavange : int = 10
var auto_scavange : bool = false
var auto_scavanger_timer : float = 2.0
var auto_scrap_amount : int = 1


#Food
var farm_time : float = 4.0
var food_per_harvest: int = 5
var auto_farm : bool = false
var auto_farm_timer : float = 2.0
var auto_food_amount : int = 1

#auto Resources
var auto_resource_timer : float = 1.0

func _ready() -> void:
	var timer = Timer.new()
	timer.wait_time = auto_resource_timer
	timer.autostart = true
	timer.timeout.connect(_on_resource_timer_timeout)
	add_child(timer)

func _on_resource_timer_timeout() -> void:
	#scrap
	if auto_scavange:
		add_scrap(auto_scrap_amount)
	
	#Food
	if auto_farm:
		add_food(auto_food_amount)
