class_name BaseMob
extends CharacterBody2D


@export var health = 1
@export var speed = 50
@export var gold_amout = 1
var damage : int


func _ready() -> void:
	$AnimatedSprite2D.play("Walk")
	
func _physics_process(delta: float) -> void:
	velocity.x = 0
	velocity.y = speed 
	move_and_slide()
	
func take_damage(damage: float):
	health -= damage
		
	if health <= 0:
		speed = 0
		GameManager.add_gold(gold_amout * GameManager.gold_drop_multiplier)
		$AnimatedSprite2D.play("Death")
		await $AnimatedSprite2D.animation_finished
		queue_free()
		
		
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if health > 0:
		if event.is_action_pressed("click_attack"):
			take_damage(GameManager.click_damage)
