extends Node

#### Interaction signals ###
signal can_interact(value,object_name)
signal interaction_on_touch(object_name)
signal interaction_start(object_name)
signal interaction_finished

##### Climb signals ####
signal can_climb(value,pos)
signal will_drop(value)

#### Health and Damage signals ###
signal take_damage(actor,value)
