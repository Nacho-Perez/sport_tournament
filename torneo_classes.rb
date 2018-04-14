class Equipo
    attr_reader :nombre, :ranking
    
    def initialize(nombre, ranking)    
        @nombre = nombre
        @ranking = ranking
    end
end