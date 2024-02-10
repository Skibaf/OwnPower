class Cart < ApplicationRecord

    #Relaciones
    has_many :orderables
    has_many :lessons, through: :orderables


    #Calculo total del carrito
    def total
        orderables.to_a.sum { |orderable| orderable.total }
    end

end
