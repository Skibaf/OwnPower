class UserController < ApplicationController
  before_action :authenticate_user!
  
  def index
    
    # falta modulo reservas
    @render_cart = true
    @mylessons = Lesson.all
  
  end

  def reserve
    @render_cart = true
    @users=User.all.where(role: "coach")
    @lessons = Lesson.all.order(dia: :asc)
    
  end
   

  

  
end
