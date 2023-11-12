extends Control

# Función para crear la matriz de transposición
func crear_matriz(mensaje: String, clave: String) -> Array:
	var matriz = []
	var index = 0
	var longitud_clave = clave.length()

	# Crear una matriz de longitud de clave x (longitud de mensaje / longitud de clave) caracteres
	while index < mensaje.length():
		var fila = []
		for i in range(longitud_clave):
			if index < mensaje.length():
				fila.append(mensaje[index])
			else:
				fila.append(" ")  # Añadir espacio en blanco si el mensaje es más corto que la matriz
			index += 1
		matriz.append(fila)

	return matriz

# Función para cifrar el mensaje
func cifrar(mensaje: String, clave: String) -> String:
	var mensaje_cifrado = ""
	var matriz = crear_matriz(mensaje, clave)
	var caracteres_clave = clave.split("")  # Dividimos la clave en caracteres
	caracteres_clave.sort()  # Ordenamos la lista de caracteres en su lugar
	var orden_clave = caracteres_clave  # Ahora 'orden_clave' es la lista ordenada

	# Cifrar basándonos en el orden de la clave
	for letra in orden_clave:
		var indice = clave.find(letra)
		for fila in matriz:
			mensaje_cifrado += fila[indice] if indice < fila.size() else ""

	# Actualizar el TextEdit de la matriz para mostrarla
	var matriz_texto = ""
	for fila in matriz:
		matriz_texto += " ".join(fila) + "\n"
	$TextEdit3.text = matriz_texto.strip_edges()

	return mensaje_cifrado.strip_edges()

# Función para descifrar el mensaje
func descifrar(mensaje_cifrado: String, clave: String) -> String:
	var mensaje_descifrado = ""
	var matriz = crear_matriz(mensaje_cifrado, clave)
	var caracteres_clave = clave.split("")
	# Luego, ordena esa lista en su lugar
	caracteres_clave.sort()
# Ahora puedes usar la lista ordenada
	var orden_clave = caracteres_clave
	var contador_letras = 0

	# Descifrar basándonos en el orden de la clave
	for letra in orden_clave:
		var indice = clave.find(letra)
		for fila in range(matriz.size()):
			if contador_letras < mensaje_cifrado.length():
				matriz[fila][indice] = mensaje_cifrado[contador_letras]
				contador_letras += 1

	# Reconstruir el mensaje original
	for fila in matriz:
		for elemento in fila:
			mensaje_descifrado += elemento if elemento != " " else ""

	return mensaje_descifrado.strip_edges()




func _on_Cifrar_pressed():
	$TextEdit4.text = cifrar($TextEdit1.text, $TextEdit2.text)

func _on_Descifrar_pressed():
	$TextEdit1.text = descifrar($TextEdit4.text, $TextEdit2.text)


func _on_button_pressed():
	$TextEdit4.text = cifrar($TextEdit1.text, $TextEdit2.text)

func _on_button_2_pressed():
	$TextEdit1.text = descifrar($TextEdit4.text, $TextEdit2.text)
