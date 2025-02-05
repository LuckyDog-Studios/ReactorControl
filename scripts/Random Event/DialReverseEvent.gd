#this event reverses control of the dial for a short time
extends RandomEvent

const EFFECT_DURATION = 5
const COOLDOWN_TIME = 20
const ROLL_CHANCE_NUMERATOR = 1
const ROLL_CHANCE_DENOMINATOR = 20

var cooldown_active = false
var effect_active = false
var cooldown_timer = 0.0
var effect_timer = 0.0


@onready var dial = get_node("/root/Game/Dial/State Machine/Turning")

#called every frame in Random Event Machine
func Update(delta: float) -> void:
	if effect_active:
		effect_timer -= delta
		if effect_timer <= 0:
			revert_effect()
	
	if cooldown_active:
		cooldown_timer -= delta
		if cooldown_timer <= 0:
			cooldown_active = false

func apply_effect() -> void:
	if effect_active:
		return
	
	effect_active = true
	effect_timer = EFFECT_DURATION
	
	#actual effect code
	if dial:
		dial.reverseControl = -1 #reverses turning control
	print("effect applied")



func revert_effect() -> void:
	effect_active = false
	if dial:
		dial.reverseControl = 1 #restores turning control
	
	apply_cooldown()



#returns true if random chance was hit
func roll_dice() -> bool:
	print("rolling chance")
	if cooldown_active:
		return false
	return super.get_roll(ROLL_CHANCE_NUMERATOR, ROLL_CHANCE_DENOMINATOR)
	

func apply_cooldown() -> void:
	cooldown_active = true
	cooldown_timer = COOLDOWN_TIME
