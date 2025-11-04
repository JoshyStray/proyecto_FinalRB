# ========================================
# SISTEMA DE GESTIÓN DE ALUMNOS
# Proyecto Final – Programación I
# Semana 8: Menú inicial y métodos base
# ========================================

# Estructura de datos inicial
$estudiantes = []

# ----------------------------------------
# Métodos vacíos (se implementarán luego)
# ----------------------------------------

def registrar_estudiante
  puts "\n[Registrar Estudiante]"
  puts "Funcionalidad aún no implementada.\n\n"
end

def ingresar_notas
  puts "\n[Ingresar Notas]"
  puts "Funcionalidad aún no implementada.\n\n"
end

def consultar_promedio
  puts "\n[Consultar Promedio]"
  puts "Funcionalidad aún no implementada.\n\n"
end

def listar_estudiantes
  puts "\n[Listar Estudiantes]"
  puts "Funcionalidad aún no implementada.\n\n"
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
      puts "\nSaliendo del sistema... ¡Hasta luego!"
      break
    else
      puts "\nOpción inválida. Intente de nuevo.\n\n"
    end
  end
end

# ----------------------------------------
# Ejecución del programa
# ----------------------------------------
mostrar_menu
# ========================================
# SISTEMA DE GESTIÓN DE ALUMNOS
# Proyecto Final – Programación I
# Semana 9: Registro de estudiantes
# ========================================

# Estructura de datos global
$estudiantes = []

# ----------------------------------------
# MÉTODOS DEL SISTEMA
# ----------------------------------------

# 1. Registrar estudiante
def registrar_estudiante
  puts "\n[Registrar Estudiante]"

  print "Ingrese el ID del estudiante (número entero): "
  id = gets.chomp.to_i

  # Validar ID único
  if $estudiantes.any? { |e| e[:id] == id }
    puts "❌ Error: Ya existe un estudiante con ese ID.\n\n"
    return
  end

  print "Ingrese el nombre completo del estudiante: "
  nombre = gets.chomp.strip

  # Validar nombre no vacío
  if nombre.empty?
    puts "❌ Error: El nombre no puede estar vacío.\n\n"
    return
  end

  # Crear registro
  estudiante = { id: id, nombre: nombre, notas: [] }
  $estudiantes << estudiante

  puts "✅ Estudiante registrado con éxito.\n\n"
end

# 2. Ingresar notas (placeholder)
def ingresar_notas
  puts "\n[Ingresar Notas]"
  puts "Funcionalidad aún no implementada.\n\n"
end

# 3. Consultar promedio (placeholder)
def consultar_promedio
  puts "\n[Consultar Promedio]"
  puts "Funcionalidad aún no implementada.\n\n"
end

# 4. Listar estudiantes (placeholder)
def listar_estudiantes
  puts "\n[Listar Estudiantes]"
  if $estudiantes.empty?
    puts "No hay estudiantes registrados.\n\n"
  else
    puts "ID\tNombre"
    puts "-" * 30
    $estudiantes.each do |e|
      puts "#{e[:id]}\t#{e[:nombre]}"
    end
    puts "\n"
  end
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
      puts "\nSaliendo del sistema... ¡Hasta luego!"
      break
    else
      puts "\nOpción inválida. Intente de nuevo.\n\n"
    end
  end
end

# ----------------------------------------
# Ejecución del programa
# ----------------------------------------
mostrar_menu
