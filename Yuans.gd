extends Control

# Preload the images (assuming you have a limited set of letters/images)
var images = {
	"A": preload("res://imagenes/A.jpg"),
	"B": preload("res://imagenes/B.png"),
	"C": preload("res://imagenes/C.png"),
	"D": preload("res://imagenes/D.png"),
	"E": preload("res://imagenes/E.png"),
	"F": preload("res://imagenes/F.png"),
	"G": preload("res://imagenes/G.png"),
	"H": preload("res://imagenes/H.png"),
	"I": preload("res://imagenes/I.png"),
	"J": preload("res://imagenes/J.png"),
	"K": preload("res://imagenes/K.png"),
	"L": preload("res://imagenes/L.png"),
	"M": preload("res://imagenes/M.png"),
	"N": preload("res://imagenes/N.jpg"),
	"Ñ": preload("res://imagenes/Ñ.png"),
	"O": preload("res://imagenes/O.png"),
	"P": preload("res://imagenes/P.png"),
	"Q": preload("res://imagenes/Q.png"),
	"R": preload("res://imagenes/R.png"),
	"S": preload("res://imagenes/S.jpg"),
	"T": preload("res://imagenes/T.png"),
	"U": preload("res://imagenes/U.jpg"),
	"V": preload("res://imagenes/V.png"),
	"W": preload("res://imagenes/W.png"),
	"X": preload("res://imagenes/X.png"),
	"Y": preload("res://imagenes/Y.jpg"),
	"Z": preload("res://imagenes/Z.png")
	}

func _ready():
	# Configura el ScrollContainer y el HScrollBar aquí si es necesario
	var scroll_container = $ScrollContainer
	var h_scroll_bar = $HScrollBar

	# Conecta la señal 'value_changed' del HScrollBar al método que manejará el desplazamiento
	h_scroll_bar.connect("value_changed", Callable(self, "_on_h_scroll_bar_value_changed"))

	# No es necesario conectar la señal 'ready' para HBoxContainer, ya que debería estar listo
	# Si necesitas realizar alguna configuración inicial para HBoxContainer, puedes hacerlo aquí

func _on_h_scroll_bar_value_changed(value):
	# Cambia la posición de desplazamiento del ScrollContainer
	$ScrollContainer.scroll_horizontal = value

func _on_button_pressed():
	var contenedor = $ScrollContainer/HBoxContainer  # Obtiene la referencia correcta al HBoxContainer
	if contenedor == null:
		print("El nodo HBoxContainer no está disponible o no se ha inicializado.")
		return

	# Obtiene el texto ingresado y lo convierte a mayúsculas
	var texto_ingresado = $TextEdit.text.to_upper()

	# Elimina todas las imágenes existentes en el contenedor
	for child in contenedor.get_children():
		child.queue_free()  # Esto eliminará cada nodo hijo de contenedor

	# Itera sobre cada letra del texto ingresado
	for letra in texto_ingresado:
		# Verifica si existe una imagen para la letra actual
		if images.has(letra):
			# Obtiene la textura correspondiente a la letra
			var textura_imagen = images[letra]
			var imagen = TextureRect.new()
			imagen.texture = textura_imagen
			# Añade la imagen al contenedor
			contenedor.add_child(imagen)
		else:
			# Si no existe una imagen para la letra, imprime un mensaje en la consola
			print("No existe imagen para la letra: " + letra)
	
	



