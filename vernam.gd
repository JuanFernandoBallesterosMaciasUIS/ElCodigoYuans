extends Control

# Tabla Baudot modificada para el cifrado de Vernam, donde cada letra o símbolo se representa con su código binario correspondiente
var baudot_table = {
	"Blanco": "00000", "E": "00001", "=": "00010", "A": "00011",
	"Espacio": "00100", "S": "00101", "I": "00110", "U": "00111",
	"<": "01000", "D": "01001", "R": "01010", "J": "01011",
	"N": "01100", "F": "01101", "C": "01110", "K": "01111",
	"T": "10000", "Z": "10001", "L": "10010", "W": "10011",
	"H": "10100", "Y": "10101", "P": "10110", "Q": "10111",
	"O": "11000", "B": "11001", "G": "11010", "↑": "11011",
	"M": "11100", "X": "11101", "V": "11110"
}


# Función para convertir un mensaje a su representación binaria utilizando la Tabla Baudot
func text_to_binary(text: String) -> String:
	text = text.to_upper()  # Convertir el texto a mayúsculas
	var binary_message = ""
	for character in text:
		if character in baudot_table:
			binary_message += baudot_table[character]
		else:
			print("Caracter no encontrado en la tabla Baudot:", character)
			return ""  # Retorna vacío si hay un caracter inválido
	return binary_message

# Función para realizar la operación XOR entre dos cadenas binarias de igual longitud
func xor_binary_strings(bin1, bin2):
	var xor_result = ""
	for i in range(len(bin1)):
		if bin1[i] == bin2[i]:
			xor_result += "0"
		else:
			xor_result += "1"
	return xor_result

# Función para convertir una cadena binaria cifrada de vuelta a texto utilizando la Tabla Baudot
func binary_to_text(binary):
	var text = ""
	for i in range(0, len(binary), 5): # Suponiendo que cada caracter tiene una longitud de 5 bits
		var binary_character = binary.substr(i, 5)
		var character_found = false
		for key in baudot_table:
			if baudot_table[key] == binary_character:
				text += key
				character_found = true
				break
		if not character_found:
			print("Secuencia binaria no encontrada en la tabla Baudot:", binary_character)
	return text

# Función para cifrar un mensaje utilizando el cifrado de Vernam
func vernam_encrypt(message: String, key: String) -> String:
	var binary_message = text_to_binary(message)
	var binary_key = text_to_binary(key)
	if binary_message == "" or binary_key == "":
		return "Error: Caracter inválido en mensaje o clave."
	if binary_message.length() != binary_key.length():
		print("La longitud del mensaje y la clave deben ser iguales.")
		return "Error: Longitud del mensaje y clave no coinciden."
	var encrypted_binary = xor_binary_strings(binary_message, binary_key)
	return binary_to_text(encrypted_binary)

# Ejemplo de uso
func _ready():
	var message = "TU MENSAJE AQUÍ"
	var key = "TU CLAVE AQUÍ"
	var encrypted_message = vernam_encrypt(message, key)
	print("Mensaje cifrado:", encrypted_message)


func _on_button_pressed():
	var message_edit = $TextEdit1
	var key_edit = $TextEdit2
	var label_result = $Label # Use the correct node name as per your scene tree
	var message = message_edit.text
	var key = key_edit.text

	# Ensure that the key is not empty and that it has the same length as the message
	if key == "" or message.length() != key.length():
		$TextEdit3.text = "La clave debe tener la misma longitud que el mensaje y no estar vacía."
		return

	var encrypted_message = vernam_encrypt(message, key)
	$TextEdit3.text =  encrypted_message


func _on_button_2_pressed():
	get_tree().change_scene_to_file("res://opciones.tscn")
