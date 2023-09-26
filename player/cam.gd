extends Spatial

var cam_point

func _ready():
	Events.connect("init_interaction",self,"_on_interaction_started")


func _process(delta):
	if cam_point:
		var new_transform = global_transform.interpolate_with(cam_point,delta * 5.0)
		global_transform = new_transform


func _on_interaction_started(obj:Interactable):
	cam_point = obj.interaction_point.global_transform



