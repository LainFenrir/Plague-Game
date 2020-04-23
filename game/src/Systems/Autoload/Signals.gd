extends Node

#### Constants ####
const CAN_INTERACT := "can_interact"
const INTERACTION_START := "interaction_start"
const INTERACTION_FINISHED := "interaction_finished"
const CAN_CLIMB := "can_climb"
const WILL_DROP := "will_drop"
const TAKE_DAMAGE := "take_damage"

#### Interaction signals ###
signal can_interact(value,object_name)
signal interaction_start(object_name)
signal interaction_finished

##### Climb signals ####
signal can_climb(value,pos)
signal will_drop(value)

#### Health and Damage signals ###
signal take_damage(actor,value)
