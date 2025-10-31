def menu_principal
  puts "===== SISTEMA DE GESTIÓN DE ALUMNOS ====="
  puts "1. Registrar estudiante"
  puts "2. Ingresar notas"
  puts "3. Consultar promedio por estudiante"
  puts "4. Listar todos los estudiantes"
  puts "5. Salir"
  print "Seleccione una opción: "
end

def main
  alumnos = []
  loop do
    menu_principal
    opcion = gets.chomp.to_i
    case opcion
    when 1
      # registrar_estudiante
    when 2
      # ingresar_notas
    when 3
      # consultar_promedio
    when 4
      # listar_alumnos
    when 5
      puts "¡Hasta luego!"
      break
    else
      puts "Opción inválida, intenta de nuevo."
    end
  end
end

main
