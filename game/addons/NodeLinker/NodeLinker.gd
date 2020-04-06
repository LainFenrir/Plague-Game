extends EditorPlugin

########################################################################

# Set the variable prefix here.
var prefix = "o"
# Change the default position the button appears at when you start Godot.
var defaultPosition = Vector2(262, 0)

########################################################################

tool
var editorInterface = get_editor_interface()
var scriptEditor = editorInterface.get_script_editor()
var ui = editorInterface.get_base_control()
const SCNTreelinks = preload("res://addons/NodeLinker/Treelinks.tscn")
var oTreelinksMain
var oTree
var oButton
var drag = false
var treeItemCount
var currentlyOpenedScript
var foundScriptOwner

func _enter_tree():
	oTreelinksMain = SCNTreelinks.instance()
	oTreelinksMain.position = defaultPosition
	scriptEditor.add_child(oTreelinksMain)
	oTree = oTreelinksMain.get_node("Tree")
	oButton = oTreelinksMain.get_node("ClickableButton")
	oTree.connect("item_selected", self, "_on_item_selected_treemenu")
	oButton.connect("mouse_entered", self, "_on_mouse_entered_button")
	oButton.connect("mouse_exited", self, "_on_mouse_exited_button")
	oButton.connect("gui_input", self, "_on_gui_input_button")
	oTree.connect("mouse_entered", self, "_on_mouse_entered_treemenu")
	oTree.connect("mouse_exited", self, "_on_mouse_exited_treemenu")
	oTree.connect("gui_input", self, "_on_gui_input_treemenu")

func _on_gui_input_button(event):
	if event is InputEventMouseMotion:
		if drag == true:
			oTreelinksMain.position += event.relative
	else:
		if event.button_index == BUTTON_RIGHT:
			if event.pressed:
				drag = true
			else:
				drag = false
		
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				oTree.visible = !oTree.visible
				oTree.clear()
				# Recreate the scene tree
				var sceneRootNode = editorInterface.get_edited_scene_root()
				var rootItem = addTreeItem(null, sceneRootNode)
				treeItemCount = 1
				buildTree(sceneRootNode, rootItem)
				
				var treeMenuWidth = 260
				var treeMenuHeight = (treeItemCount*26)+17
				treeMenuHeight = clamp(treeMenuHeight,0,680) #Maximum height is needed for vertical scroll bar to appear
				oTree.rect_size = Vector2(treeMenuWidth, treeMenuHeight)

func buildTree(node,treeItem):
	for N in node.get_children():
		if N.owner == get_tree().edited_scene_root: #avoids "runtime-generated nodes" (extra children)
			var add = addTreeItem(treeItem, N)
			
			treeItemCount += 1 #just for the purpose of resizing the menu
			
			if N.get_child_count() > 0:
				buildTree(N,add)

func addTreeItem(parentOfThisOne, assignNode):
	var add = oTree.create_item(parentOfThisOne)
	add.set_text(0, assignNode.get_name())
	add.set_metadata(0, assignNode) #Allows the generated tree to reference the node
	return add

func _exit_tree():
	oTreelinksMain.free()

#Press left mouse button down
var treeSelection = null
func _on_item_selected_treemenu():
	treeSelection = oTree.get_selected().get_metadata(0)
#Release left mouse button
func _on_gui_input_treemenu(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if !event.pressed: #let go of left mouse button
				treeExecute()

func treeExecute():
	var desiredLink = treeSelection
	
	currentlyOpenedScript = scriptEditor.get_current_script()
	var sceneRootNode = editorInterface.get_edited_scene_root()
	
	if currentlyOpenedScript == sceneRootNode.get_script():
		foundScriptOwner = sceneRootNode
	else:
		foundScriptOwner = null #a workaround, as returning isn't working properly in the recursive function
		searchAllNodesForScriptOwner(sceneRootNode)
	
	if foundScriptOwner != null:
		var theGeneratedPath = foundScriptOwner.get_path_to(desiredLink)
		var nodeName = desiredLink.get_name()
		var finalString = "onready var "+str(prefix)+str(nodeName)+" = $'"+str(theGeneratedPath)+"'"
		
		#OS.set_clipboard(finalString) #<--- Use this instead if SimulateKeypress.exe doesn't work.
		OS.execute("addons/NodeLinker/SimulateKeypress.exe",[finalString],true,[],false)
	else:
		print("Could not find a node in the scene holding the currently opened script.")

# For relativity, need the script's node in order to compare to the desired "Link node".
# Iterate over SceneTree to find a Node that holds currentlyOpenedScript. Godot's built-in lookup operates the same (when dragging a node into the script window) and Godot can even return the wrong node path if two nodes have the same script.
func searchAllNodesForScriptOwner(node):
	for N in node.get_children():
		if currentlyOpenedScript == N.get_script():
			foundScriptOwner = N
			return N
		if N.get_child_count() > 0:
			searchAllNodesForScriptOwner(N)


var mouseOnButton
var mouseOnTreeMenu
func _on_mouse_entered_treemenu():
	mouseOnTreeMenu = true
func _on_mouse_exited_treemenu():
	mouseOnTreeMenu = false
	oTree.visible = false
func _on_mouse_entered_button():
	mouseOnButton = true
func _on_mouse_exited_button():
	mouseOnButton = false
	yield(get_tree(), 'idle_frame') #wait a frame for signals to update (mouseOnTreeMenu becomes true)
	if mouseOnTreeMenu == false:
		oTree.visible = false
