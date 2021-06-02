class Player < ApplicationRecord
    belongs_to :board, optional: true
    before_create :asignacion

    validates :id, uniqueness: true

    def asignacion
        n = Player.count
        if n % 2 == 0
            self.nombre = "O"
        else
            self.nombre = "X"
        end
    end

end
