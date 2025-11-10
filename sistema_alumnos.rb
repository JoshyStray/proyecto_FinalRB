# ========================================
# SISTEMA DE GESTIÓN DE ALUMNOS
# Proyecto Final – Programación I
# Semana 14: Listar estudiantes con promedio
# ========================================

require 'csv'

ARCHIVO_DATOS = "estudiantes.csv"
$estudiantes = []

# ----------------------------------------
# FUNCIONES DE ARCHIVO
# ----------------------------------------

def cargar_datos
  if File.exist?(ARCHIVO_DATOS)
    $estudiantes.clear
    CSV.foreach(ARCHIVO_DATOS, headers: true) do |fila|
      next if fila.nil? || fila["id"].nil?

      notas_str = fila["notas"] || ""
      separador = notas_str.include?(";") ? ";" : ","
      notas = notas_str.split(separador).map(&:to_f).reject(&:zero?) rescue []

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
# FUNCIONES DEL SISTEMA
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

  $estudiantes << { id: id, nombre: nombre, notas: [] }
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

  puts "Actualmente tiene las notas: #{estudiante[:notas].join(', ')}"
  print "¿Cuántas notas nuevas desea ingresar? "
  cantidad = gets.chomp.to_i

  cantidad.times do |i|
    print "Ingrese la nota ##{i + 1} (0.00 - 100.00): "
    nota = gets.chomp.to_f
    if nota < 0 || nota > 100
      puts "❌ Error: La nota debe estar entre 0 y 100."
      redo
    end
    estudiante[:notas] << nota
  end

  puts "✅ Notas actualizadas correctamente para #{estudiante[:nombre]}.\n\n"
end

def consultar_promedio
  puts "\n[Consultar Promedio]"
  print "Ingrese el ID del estudiante: "
  id = gets.chomp.to_i

  estudiante = $estudiantes.find { |e| e[:id] == id }

  if estudiante.nil?
    puts "❌ Error: No se encontró un estudiante con ese ID.\n\n"
    return
  end

  if estudiante[:notas].empty?
    puts "⚠️ El estudiante #{estudiante[:nombre]} no tiene notas registradas.\n\n"
    return
  end

  promedio = (estudiante[:notas].sum / estudiante[:notas].size).round(2)
  puts "📘 Estudiante: #{estudiante[:nombre]}"
  puts "Notas: #{estudiante[:notas].join(', ')}"
  puts "Promedio: #{promedio}\n\n"
end

# 🆕 Semana 14: Listar con promedio
def listar_estudiantes
  puts "\n[Listar Estudiantes con Promedio]"
  if $estudiantes.empty?
    puts "No hay estudiantes registrados.\n\n"
  else
    puts "ID\tNombre\t\tNotas\t\tPromedio"
    puts "-" * 60
    $estudiantes.each do |e|
      notas_str = e[:notas].empty? ? "Sin notas" : e[:notas].join(", ")
      promedio = e[:notas].empty? ? "N/A" : (e[:notas].sum / e[:notas].size).round(2)
      puts "#{e[:id]}\t#{e[:nombre].ljust(16)}\t#{notas_str.ljust(15)}\t#{promedio}"
    end
    puts "\n"
  end
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
    puts "4. Listar todos los estudiantes con promedio"
    puts "5. Salir"
    print "Seleccione una opción: "

    opcion = gets.chomp

    case opcion
    when "1" then registrar_estudiante
    when "2" then ingresar_notas
    when "3" then consultar_promedio
    when "4" then listar_estudiantes
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
