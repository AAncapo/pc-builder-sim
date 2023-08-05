extends VBoxContainer

signal empty

onready var tabsContainer := $"%TabContainer"
onready var tabName = $"%current_tab_name"

var current_tab setget ,get_current_tab
func get_current_tab(): 
	return tabsContainer.get_current_tab_control()
var idx = 0


func _ready():
	enable_nav_buttons(tabsContainer.get_tab_count() > 1)


func enable_nav_buttons(value):
	$"%next".disabled = !value
	$"%prev".disabled = !value


func _on_prev_pressed():
	if tabsContainer.get_tab_count() > 0:
		idx -= 1
		if idx < 0:
			idx = tabsContainer.get_tab_count()-1
		tabsContainer.current_tab = idx
		tabName.text = self.current_tab.name

func _on_next_pressed():
	if tabsContainer.get_tab_count() > 0:
		idx += 1
		if idx > tabsContainer.get_tab_count()-1:
			idx = 0
		tabsContainer.current_tab = idx
		tabName.text = self.current_tab.name


func _on_TabContainer_child_entered_tree(node:Node):
	node.connect("tree_exited", self, "on_tab_child_exited")
	enable_nav_buttons(tabsContainer.get_tab_count() > 1)
	tabName.text = self.current_tab.name


func on_tab_child_exited():
#	yield(get_tree().create_timer(0.1),"timeout")
	tabName.text = ''
	if self.current_tab:
		tabName.text = self.current_tab.name
	enable_nav_buttons(tabsContainer.get_tab_count() > 1)
	if tabsContainer.get_tab_count() == 0:
		emit_signal("empty")

