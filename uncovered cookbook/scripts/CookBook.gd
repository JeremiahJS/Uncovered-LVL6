extends Node2D

#video source: https://www.youtube.com/watch?v=PztV8LiQk34


var isopened = false
onready var pg_container = $Book/ClipController/HBoxContainer 
var num_pgs = 1
var current_pg = 2
var pg_width = 216
var cooldown = false

func _ready():
	num_pgs = pg_container.get_child_count()
	pg_width = pg_container.rect_min_size.x
	print("Number of Pages:", " ",num_pgs)


func _on_Button_pressed():
	var tween = get_tree().create_tween()
	if isopened != true:
		$Button.flip_h = true
		tween.tween_property(self,"position",Vector2(587,0),.5).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
		pg_container.rect_position.x = 0
		$"Book/Book Open".play()
		isopened = !isopened
	else:
		$Button.flip_h = false
		tween.tween_property(self,"position",Vector2(0,0),.5).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
		$"Book/Book Close".play()
		isopened = !isopened


func _on_Previous_pressed():
	if current_pg > 2 and cooldown == false:
		cooldown = true
		current_pg -= 2
		animateGridPositiion(pg_container.rect_position.x + pg_width)
		$"Book/Page Flip Sound".play()
		yield(get_tree().create_timer(.5), "timeout")
		cooldown = false



func _on_Next_pressed():
	if current_pg <= num_pgs and cooldown == false:
		cooldown = true
		current_pg += 2
		animateGridPositiion(pg_container.rect_position.x - pg_width)
		$"Book/Page Flip Sound".play()
		yield(get_tree().create_timer(.5), "timeout")
		cooldown = false
		print(current_pg)

func animateGridPositiion(finalValue):
	var tween = get_tree().create_tween()
	yield(tween.set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT).tween_property(pg_container , "rect_position", Vector2(finalValue,0), 0.3),"finished")
