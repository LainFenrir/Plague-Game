extends Node

#### Interaction signals ###
signal can_interact(value)
signal interaction_start
signal interaction_finished
signal interaction_on_touch

##### Climb signals ####
signal can_climb(value,pos)
signal will_drop(value)

#### Health and Damage signals ###
signal take_damage(actor,value)
