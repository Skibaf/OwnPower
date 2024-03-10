class UserController < ApplicationController
  before_action :authenticate_user!
  
  def index
    
    # falta modulo reservas
    @render_cart = true
    @mylessons = Lesson.all
    @Reservations = Reservation.all.where(user_id: current_user)
    
  
  end

  def reserve
    @render_cart = true
    @query = Lesson.ransack(params[:q])
    @lessons_res = @query.result.includes(:category, :coach).order(dia: :asc)
    
  end
   

  

  
end
