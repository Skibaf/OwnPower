# == Schema Information
#
# Table name: carts
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Cart < ApplicationRecord

    #Relaciones
    has_many :orderables
    has_many :lessons, through: :orderables


    #Calculo total del carrito
    def total
        orderables.to_a.sum { |orderable| orderable.total }
    end

end
