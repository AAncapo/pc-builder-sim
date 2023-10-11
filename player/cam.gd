extends Spatial

var cam_point setget setCamPoint
func setCamPoint(val):
	cam_point = val
	var t = create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	t.tween_property(self,'global_transform',cam_point,0.5)


func _ready():
	Events.connect("init_interaction",self,"_on_interaction_started")

	Events.connect("move_camera_pls",self,'on_move_camera')


func on_move_camera():
	var p = $"%Position3D2"
	p.global_rotation.y = deg2rad(180)
	self.cam_point = p.global_transform

func _on_interaction_started(obj:Interactable):
	self.cam_point = obj.interaction_point.global_transform
