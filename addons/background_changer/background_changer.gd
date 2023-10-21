class_name BackgroundChanger

extends Sprite2D

## You can assign background directly in the editor
@export var backgroundSprites: Array[CompressedTexture2D]
## Or you can assign a folder with background images
@export var pathToBackgrounds: String
## If you want to change background by clicking on a button you can assign it here
@export var nextButton: Button

## Index of the current background
var index: int = 0
## Current background textures paths
var backgrounds: Array[String] = []


# Called when the node enters the scene tree for the first time.
# Random pick the background texture
func _ready():
	if backgroundSprites.size() > 0:
		index = randi() % len(backgroundSprites)
		texture = backgroundSprites[index]
	else:
		_loadSprites()
		index = randi() % len(backgrounds)
		texture = ResourceLoader.load(backgrounds[index])

## Load all background textures from the folder
func _loadSprites() -> void:
	if pathToBackgrounds == "":
		return

	var dir = DirAccess.open(pathToBackgrounds)
	dir.list_dir_begin()
	var file = dir.get_next()
	while file != "":
		if file.ends_with(".png") or file.ends_with(".jpg") or file.ends_with(".jpeg"):
			backgrounds.append(pathToBackgrounds + file)
		file = dir.get_next()
	dir.list_dir_end()

## Change background texture to the next one
func _next_background() -> void:
	if backgroundSprites.size() == 0 and backgrounds.size() == 0:
		return

	if backgroundSprites.size() > 0:
		index = (index + 1) % backgroundSprites.size()
		texture = backgroundSprites[index]
		if nextButton != null:
			nextButton.text = backgroundSprites[index].resource_path + " " + "Index: " + str(index)
	else:
		index = (index + 1) % backgrounds.size()
		texture = ResourceLoader.load(backgrounds[index])
		if nextButton != null:
			nextButton.text = backgrounds[index] + " " + "Index: " + str(index)
