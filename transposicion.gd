extends Control

# Función para crear la matriz de transposición
func crear_matriz(mensaje: String, clave: String) -> Array:
	var matriz = []
	var index = 0
	var longitud_clave = clave.length()
	var ultimo_caracter = " "  # Inicializar con espacio en blanco

	# Crear una matriz de longitud de clave x (longitud de mensaje / longitud de clave) caracteres
	while index < mensaje.length():
		var fila = []
		for i in range(longitud_clave):
			if index < mensaje.length():
				fila.append(mensaje[index])
				ultimo_caracter = mensaje[index]  # Actualizar el último caracter
			else:
				fila.append(ultimo_caracter)  # Llenar con el último caracter del mensaje
			index += 1
		matriz.append(fila)

	return matriz


# Ajusta la clave para que esté alineada con las columnas de la matriz.
func ajustar_clave_para_matriz(clave: String) -> String:
	var clave_ajustada = ""
	for letra in clave:
		clave_ajustada += letra + " "
	return clave_ajustada.strip_edges(true)  # true indica que solo se quitan los espacios al final

# Esta función actualizará el TextEdit de la matriz para mostrarla junto con la clave ajustada
func actualizar_matriz_texto(matriz: Array, clave: String):
	var clave_ajustada = ajustar_clave_para_matriz(clave)
	var matriz_texto = clave_ajustada + "\n\n"  # Añade la clave ajustada y dos saltos de línea para el espacio
	for fila in matriz:
		matriz_texto += " ".join(fila) + "\n"
	$TextEdit3.text = matriz_texto.strip_edges()  # Elimina los espacios al principio y al final


	
# Función para cifrar el mensaje
func cifrar(mensaje: String, clave: String) -> String:
	var mensaje_cifrado = ""
	var matriz = crear_matriz(mensaje, clave)
	var caracteres_clave = clave.split("")  # Dividimos la clave en caracteres
	caracteres_clave.sort()  # Ordenamos la lista de caracteres en su lugar
	var orden_clave = caracteres_clave  # Ahora 'orden_clave' es la lista ordenada

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
	var longitud_clave = clave.length()
	var num_filas = int(ceil(mensaje_cifrado.length() / float(longitud_clave)))
	var matriz = []

	# Inicializar la matriz con espacios
	for i in range(num_filas):
		var fila = []
		for j in range(longitud_clave):
			fila.append(" ")
		matriz.append(fila)

	var caracteres_clave = clave.split("")  # Dividimos la clave en caracteres
	var orden_clave = caracteres_clave.duplicate()
	orden_clave.sort()  # Ordenamos la lista de caracteres en su lugar

	# Distribuir el mensaje cifrado en la matriz según la clave ordenada
	var contador_letras = 0
	for letra in orden_clave:
		var indice = caracteres_clave.find(letra)
		for i in range(num_filas):
			if contador_letras < mensaje_cifrado.length():
				matriz[i][indice] = mensaje_cifrado[contador_letras]
				contador_letras += 1

	# Reconstruir el mensaje original leyendo las filas
	for fila in matriz:
		for caracter in fila:
			if caracter != " ":
				mensaje_descifrado += caracter

	return mensaje_descifrado



func _on_button_pressed():
	var mensaje_cifrado = cifrar($TextEdit1.text, $TextEdit2.text)
	$TextEdit4.text = mensaje_cifrado
	# Llama a actualizar_matriz_texto con la clave y la matriz recién creada.
	actualizar_matriz_texto(crear_matriz($TextEdit1.text, $TextEdit2.text), $TextEdit2.text)
	

func _on_button_2_pressed():
	$TextEdit4.text = descifrar($TextEdit1.text, $TextEdit2.text)
