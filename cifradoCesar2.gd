extends Control

var abc = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","ñ","o","p","q","r","s","t","u","v","w","x","y","z"]

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	var texto = $HBoxContainer2/TextEdit.text
	var cifrado = ""
	print(texto)
	
	for i in texto:
		for j in range(len(abc)):
			if i == abc[j]:
				cifrado += abc[(j + 3) % 27]
	
	print(cifrado)
	$HBoxContainer2/TextEdit2.text = cifrado



func _on_button_2_pressed():
	var texto = $HBoxContainer2/TextEdit.text
	var cifrado = ""
	
	for i in texto:
		for j in range(len(abc)):
			if i == abc[j]:
				cifrado += abc[(j - 3) % 27]
	
	$HBoxContainer2/TextEdit2.text = cifrado


func _on_button_3_pressed():
	get_tree().change_scene_to_file("res://opciones.tscn")
