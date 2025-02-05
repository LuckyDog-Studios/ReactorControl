#this event reverses control of the dial for a short time
extends RandomEvent

const effect_duration = 5
const cooldown_time = 20
var cooldown_active = false
var effect_active = false

const roll_chance_numer = 1
const roll_chance_denom = 20
#this for example means 1/80 chance

@onready var dial = get_node("/root/Game/Dial/State Machine/Turning")


func apply_effect() -> void:
	if effect_active:
		return
	effect_active = true
	#actual effect code
	dial.reverseControl = -1 #reverses turning control
	print("effect applied")
	await get_tree().create_timer(effect_duration).timeout # allow effect to stay for (duration) seconds
	
	#revert effect
	effect_active = false
	revert_effect()


func revert_effect() -> void:
	dial.reverseControl = 1
	apply_cooldown()



#returns true if random chance was hit
func roll_dice() -> bool:
	print("rolling chance")
	if cooldown_active:
		return false
	return super.get_roll(roll_chance_numer, roll_chance_denom)
	

func apply_cooldown() -> void:
	cooldown_active = true
	await get_tree().create_timer(cooldown_time).timeout
	cooldown_active = false
