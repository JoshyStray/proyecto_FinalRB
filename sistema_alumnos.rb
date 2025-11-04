# ========================================
# SISTEMA DE GESTIÓN DE ALUMNOS
# Proyecto Final – Programación I
# Semana 12: Manejo de archivos CSV (guardar y cargar)
# ========================================

require 'csv'

# Archivo donde se guardarán los datos
ARCHIVO_DATOS = "estudiantes.csv"

# Estructura global
$estudiantes = []

# ----------------------------------------
# FUNCIONES DE ARCHIVOS
# ----------------------------------------

def cargar_datos
  if File.exist?(ARCHIVO_DATOS)
    $estudiantes.clear
    CSV.foreach(ARCHIVO_DATOS, headers: true) do |fila|
      notas = fila["notas"].split(";").map(&:to_f)
      $estudiantes << {
        id: fila["id"].to_i,
        nombre: fila["nombre"],
        notas: notas
      }
    end
    puts "📂 Datos cargados correctamente desde #{ARCHIVO_DATOS}.\n\n"
  else
    puts "⚠️ No se encontró archivo de datos, iniciando base vacía.\n\n"
  end
end

def guardar_datos
  CSV.open(ARCHIVO_DATOS, "w", write_headers: true, headers: ["id", "nombre", "notas"]) do |csv|
    $estudiantes.each do |e|
      csv << [e[:id], e[:nombre], e[:notas].join(";")]
    end
  end
  puts "💾 Datos guardados correctamente en #{ARCHIVO_DATOS}."
end

# ----------------------------------------
# FUNCIONALIDADES DEL SISTEMA
# ----------------------------------------

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

def consultar_promedio
  puts "\n[Consultar Promedio]"
  puts "Funcionalidad aún no implementada.\n\n"
end

# ----------------------------------------
# MENÚ PRINCIPAL
# ----------------------------------------

def mostrar_menu
  loop do
    puts "===== SISTEMA DE GESTIÓN DE ALUMNOS ====="
    puts "1. Registrar estudiante"
    puts "2. Ingresar notas"
    puts "3. Consultar promedio por estudiante"
    puts "4. Listar todos los estudiantes"
    puts "5. Salir"
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
      guardar_datos
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

cargar_datos
mostrar_menu
