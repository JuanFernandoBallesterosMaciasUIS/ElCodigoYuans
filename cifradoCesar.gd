extends Control


var abc = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","Ñ","O","P","Q","R","S","T","U","V","W","X","Y","Z"]

func _ready() -> void:
	print("Hola mundo")




func _on_button_pressed():
	var texto = $HBoxContainer2/Input.text
	var cifrado = ""
	
	for i in texto:
		for j in range(len(abc)):
			if i == abc[j]:
				cifrado += abc[(j + 3) % 27]
	
	$HBoxContainer2/Output.text = cifrado


func _on_button_2_pressed():
	var texto = $HBoxContainer2/Input.text
	var cifrado = ""
	
	for i in texto:
		for j in range(len(abc)):
			if i == abc[j]:
				cifrado += abc[(j - 3) % 27]
	
	$HBoxContainer2/Output.text = cifrado


