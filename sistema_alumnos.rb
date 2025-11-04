# ========================================
# SISTEMA DE GESTIÓN DE ALUMNOS
# Proyecto Final – Programación I
# Semana 11: Integración parcial y pruebas en memoria
# ========================================

# Estructura global
$estudiantes = []

# ----------------------------------------
# MÉTODOS DEL SISTEMA
# ----------------------------------------

# Registrar estudiante
def registrar_estudiante
  puts "\n[Registrar Estudiante]"

  print "Ingrese el ID del estudiante (número entero): "
  id = gets.chomp.to_i

  if $estudiantes.any? { |e| e[:id] == id }
    puts "❌ Error: Ya existe un estudiante con ese ID.\n\n"
    return
  end

  print "Ingrese el nombre completo del estudiante: "
  nombre = gets.chomp.strip

  if nombre.empty?
    puts "❌ Error: El nombre no puede estar vacío.\n\n"
    return
  end

  estudiante = { id: id, nombre: nombre, notas: [] }
  $estudiantes << estudiante
  puts "✅ Estudiante registrado con éxito.\n\n"
end

# Ingresar notas
def ingresar_notas
  puts "\n[Ingresar Notas]"
  print "Ingrese el ID del estudiante: "
  id = gets.chomp.to_i

  estudiante = $estudiantes.find { |e| e[:id] == id }

  if estudiante.nil?
    puts "❌ Error: No existe un estudiante con ese ID.\n\n"
    return
  end

  notas = []

  3.times do |i|
    print "Ingrese la nota ##{i + 1} (0.00 - 100.00): "
    nota = gets.chomp

    if nota !~ /^\d+(\.\d+)?$/
      puts "❌ Error: Debe ingresar un número válido."
      redo
    end

    nota = nota.to_f

    if nota < 0 || nota > 100
      puts "❌ Error: La nota debe estar entre 0 y 100."
      redo
    end

    notas << nota
  end

  estudiante[:notas] = notas
  puts "✅ Notas registradas correctamente para #{estudiante[:nombre]}.\n\n"
end

# Consultar promedio (a implementar en semana 13)
def consultar_promedio
  puts "\n[Consultar Promedio]"
  puts "Funcionalidad aún no implementada.\n\n"
end

# Listar estudiantes
def listar_estudiantes
  puts "\n[Listar Estudiantes]"
  if $estudiantes.empty?
    puts "No hay estudiantes registrados.\n\n"
  else
    puts "ID\tNombre\t\tNotas"
    puts "-" * 40
    $estudiantes.each do |e|
      notas_str = e[:notas].empty? ? "Sin notas" : e[:notas].join(", ")
      puts "#{e[:id]}\t#{e[:nombre]}\t#{notas_str}"
    end
    puts "\n"
  end
end

# ----------------------------------------
# SIMULACIÓN DE PRUEBAS (opcional)
# ----------------------------------------

def simulacion_pruebas
  puts "\n[Simulación de pruebas con datos de ejemplo]"
  $estudiantes.clear
  $estudiantes << { id: 1, nombre: "Ana Torres", notas: [90, 85, 88] }
  $estudiantes << { id: 2, nombre: "Luis Ramírez", notas: [70, 80, 75] }
  $estudiantes << { id: 3, nombre: "María Gómez", notas: [95, 98, 100] }
  puts "✅ Se han cargado 3 estudiantes de prueba.\n\n"
end

# ----------------------------------------
# Menú principal
# ----------------------------------------

def mostrar_menu
  loop do
    puts "===== SISTEMA DE GESTIÓN DE ALUMNOS ====="
    puts "1. Registrar estudiante"
    puts "2. Ingresar notas"
    puts "3. Consultar promedio por estudiante"
    puts "4. Listar todos los estudiantes"
    puts "5. Cargar datos de prueba"
    puts "6. Salir"
    print "Seleccione una opción: "

    opcion = gets.chomp

    case opcion
    when "1"
      registrar_estudiante
    when "2"
      ingresar_notas
    when "3"
      consultar_promedio
    when "4"
      listar_estudiantes
    when "5"
      simulacion_pruebas
    when "6"
      puts "\nSaliendo del sistema... ¡Hasta luego!"
      break
    else
      puts "\nOpción inválida. Intente de nuevo.\n\n"
    end
  end
end

# ----------------------------------------
# EJECUCIÓN
# ----------------------------------------
mostrar_menu
