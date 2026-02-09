class_name Arrow
extends Area2D

var travelled_distance = 0
@export var speed = 500
@export var arrow_range = 1000


func _physics_process(delta):
	var direction = Vector2(0, -1)
	position += direction * speed * delta
	travelled_distance += speed * delta
	if travelled_distance > arrow_range:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage(GameManager.arrow_damage)
