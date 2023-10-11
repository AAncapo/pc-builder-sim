extends Control

var current_mode_tag

func _ready():
	for b in $"%FilterContainer".get_children():
		b.pressed = false


func _unhandled_input(event):
	if event.is_action_pressed('prev_mode'):
		var filters:Array = $"%FilterContainer".filters
		if !current_mode_tag: current_mode_tag = 'receiver'
		for b in filters:
			if b.name.to_lower() == current_mode_tag:
				var prev_idx = filters.find(b)-1
				if prev_idx < 0: prev_idx = filters.size()-1
				filters[prev_idx].emit_signal('pressed')
				filters[prev_idx].grab_focus()
				return
	if event.is_action_pressed('next_mode'):
		var filters:Array = $"%FilterContainer".filters
		if !current_mode_tag: current_mode_tag = 'web'
		for b in filters:
			if b.name.to_lower() == current_mode_tag:
				var next_idx = filters.find(b)+1
				if next_idx >= filters.size(): next_idx = 0
				filters[next_idx].emit_signal('pressed')
				filters[next_idx].grab_focus()
				return


func _on_FilterContainer_apply_filter(tag, _show_all):
	current_mode_tag = tag
	Events.emit_signal("interact",tag)
