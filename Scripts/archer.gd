extends Area2D
@onready var arrow_spawns: Node2D = $ArrowSpawns
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta):
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		animated_sprite_2d.play("Shoot")
		var target_enemy = enemies_in_range.front()
	else:
		animated_sprite_2d.play("Idle")

func fire():
	const ARROW = preload("res://Scenes/Arrow/Arrow.tscn")
	var spawn_nodes = arrow_spawns.get_children()
	for i in range(GameManager.arrow_count):
		if i < spawn_nodes.size():
			var new_arrow = ARROW.instantiate()
			var spawn_points = spawn_nodes[i]
			new_arrow.global_position = spawn_points.global_position
			new_arrow.global_rotation = global_rotation
			get_tree().root.add_child(new_arrow)
	


func _on_timer_timeout() -> void:
	if get_overlapping_bodies():
		fire()
	else:
		pass
