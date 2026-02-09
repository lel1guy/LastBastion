extends Node2D


signal upgrade_menu_open

# Resource Buttons/Timer Ref
@onready var scavange_button: Button = $BaseUserInterface/RoomsButtons/ScavangeButton
@onready var scavange_timer: Timer = $BaseUserInterface/RoomsButtons/ScavangeButton/ScavangeTimer
@onready var farm_button: Button = $BaseUserInterface/RoomsButtons/FarmButton
@onready var farm_timer: Timer = $BaseUserInterface/RoomsButtons/FarmButton/FarmTimer
@onready var auto_food: ColorRect = $BaseUserInterface/Rooms/Farm/AutoFood
@onready var auto_scrap: ColorRect = $BaseUserInterface/Rooms/StoreRoom/AutoScrap
@onready var auto_food_load: AnimatedSprite2D = $BaseUserInterface/Rooms/Farm/AutoFood/Auto_Food_Load
@onready var auto_scrap_load: AnimatedSprite2D = $BaseUserInterface/Rooms/StoreRoom/AutoScrap/Auto_Scrap_Load


#Spwan Ponints
@onready var mob_spawn_points: Node2D = $MobSpawnPoints
@onready var archer_spawn_points: Node2D = $ArcherSpawnPoints


#Random mob scenes
@export var mobs : Array[PackedScene] = []

#Random Archer Scenes
@export var archer : Array[PackedScene] = []

#choses a random mob and spawns it
func spwan_mob():
	var random_mob_scene = mobs.pick_random()
	var mob = random_mob_scene.instantiate()
	var mob_spawn = mob_spawn_points.get_children()
	var random_mob_spawn = mob_spawn.pick_random()
	mob.global_position = random_mob_spawn.global_position
	add_child(mob)

func _on_mob_spwan_timer_timeout() -> void:
	spwan_mob()
	
#Archer Spawns
func spawn_archer():
	var points = archer_spawn_points.get_children()
	if GameManager.archer_count <= points.size():
		var random_archer_scene = archer.pick_random()
		var archer_instance = random_archer_scene.instantiate()
		var spawn_point = points[GameManager.archer_count - 1]
		archer_instance.global_position = spawn_point.global_position
		add_child(archer_instance)



# Game Navigation
func _on_upgrade_menu_button_pressed() -> void:
	upgrade_menu_open.emit()

func _process(delta: float) -> void:
	if GameManager.storeroom_unlocked:
		$BaseUserInterface/Rooms/StoreRoom.visible = true
	
	if GameManager.farm_unlocked:
		$BaseUserInterface/Rooms/Farm.visible = true

#Resources creation 
func _on_scavange_button_pressed() -> void:
	if GameManager.storeroom_unlocked:
		scavange_button.disabled = true
		scavange_timer.start(GameManager.scavange_time)
		auto_scrap.visible = true
		


func _on_farm_button_pressed() -> void:
	if GameManager.farm_unlocked:
		farm_button.disabled = true
		farm_timer.start(GameManager.farm_time)
		auto_food.visible = true
		auto_food_load.play("default")
		
		

func _on_scavange_timer_timeout() -> void:
	scavange_button.disabled = false
	GameManager.add_scrap(GameManager.scrap_per_scavange)
	auto_scrap.visible = false
	auto_scrap_load.play("default")


func _on_farm_timer_timeout() -> void:
	farm_button.disabled = false
	GameManager.add_food(GameManager.food_per_harvest)
	auto_food.visible = false
