# TORNEO DEPORTIVO DE SERIE

require_relative 'torneo_classes'  

@equipos = []
@num_equipos = nil

def menu_main                       #Menú principal del torneo
    puts "\nElige una acción:"
    puts "1. Inscribir equipos"
    puts "2. Listar equipos"
    puts "3. Listar enfrentamientos"
    puts "  0. Salir del programa"
    
    option = gets.chomp.to_i
    
    case option
        when 1 then inscribir
        when 2 then listar_equipos
        when 3 then listar_cruces
        when 0 then exit
        else puts "-> Elige una opción correcta"
            
    end
end
def inscribir                       #Inscribe los equipos en el torneo
    if @equipos.length != 0              #Ya hay equipos inscritos previamente
        puts "\nYa hay equipos inscritos en el torneo."
        print "¿Está seguro que desea inscribir nuevos equipos? "
        case gets.chomp.downcase
            when "si" 
                @equipos = []
                introducir_equipos
            when "no" then puts "-> Inscripción cancelada"
            else puts "-> Opción no válida"
        end
    else                                 #No hay equipos inscritos aún
        introducir_equipos    
    end
    menu_main
end
def introducir_equipos              #Introduce equipos y su ranking en el torneo
    print "\n-> Introduzca el número de equipos que desea inscribir en el torneo: "
    @num_equipos = gets.chomp.to_i
    
    @num_equipos.times do
        print "\nNombre del equipo: "
        name_equipo = gets.chomp
        while comprobar_equipo(name_equipo) == false
            puts "-> Nombre del equipo ya asignado anteriormente."
            print "\nIntroduzca otro nombre de equipo: "
            name_equipo = gets.chomp
        end
        
        print "Ranking del equipo: "
        rank_equipo = gets.chomp.to_i
        while comprobar_ranking(rank_equipo) == false
            puts "-> Posición de ranking no válida."
            print "Por favor, asigne otro ranking a este equipo: " 
            rank_equipo = gets.chomp.to_i
        end
        
        equipo = Equipo.new(name_equipo, rank_equipo)   #Crear nuevo equipo
        @equipos.push(equipo)                           #Guardar nuevo equipo
    end
    
    puts "\n-> Inscripción finalizada"
end
def comprobar_equipo(name)
    isOK = true     #name será válido mientras no se encuentre que está asignado
    @equipos.each do |equipo|
        if equipo.nombre == name
            isOK = false             #nombre no válido, ya asignado previamente
        end            
    end    
    return isOK
end
def comprobar_ranking(rank)
    isOK = true     #rank será válido mientras no se encuentre que está asignado
    @equipos.each do |equipo|
        if (equipo.ranking == rank) || (rank > @num_equipos)
            isOK = false             #ranking no válido, ya asignado previamente
        end
    end  
    return isOK
end
def listar_equipos                  #Listar el ranking de los equipos inscritos
    if @equipos.length == 0 
        puts "-> No hay equipos inscritos"
        menu_main                           #Volver al menú principal
    else 
        puts "\nRANKING DEL TORNEO"
        rank = 1
        while rank <= @num_equipos          #Listar todos los equipos del torneo
            puts "#{rank}. #{encontrar_equipo(rank)}"
            rank += 1
        end
        menu_main                           #Volver al menú principal
    end
end
def listar_cruces                   #Listar los enfrentamientos entre los equipos
    if @equipos.length == 0 
        puts "-> No hay equipos inscritos"
        menu_main                           #Volver al menú principal
    else     
        puts "\nENFRENTAMIENTOS DEL TORNEO"
        if (@equipos.length % 2) == 0           #Nº equipos par
            asignar_cruces(1, @equipos.length)
        else                                    #Nº equipos impar
            puts "(1) #{encontrar_equipo(1)} no juega"
            asignar_cruces(2, @equipos.length)
        end
        menu_main
    end    
end
def encontrar_equipo(ranking)       #Muestra el equipo de un determinado ranking
    @equipos.each do |equipo|
        if equipo.ranking == ranking
            return equipo.nombre    
        end
    end
end    
def asignar_cruces(inicio, final)   #Listar enfrentamientos en serie
    while inicio < final                #Si se cumple, quedan enfrentamientos que mostrar
        puts "(#{inicio}) #{encontrar_equipo(inicio)} vs (#{final}) #{encontrar_equipo(final)}"
        inicio += 1                     #Asignación de serie
        final -= 1                      #Ej: 1-4 equipos -> (1)vs(4) y (2)vs(3)
    end
end

puts "Bienvenidos al I TORNEO DEPORTIVO DE SERIE"
menu_main