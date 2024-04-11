class UserController < ApplicationController
  before_action :authenticate_user!
  
  def index
     @render_cart = true
    #@mylessons = Lesson.all
    #@Reservations = Reservation.all.where(user_id: current_user)
     @q = Reservation.ransack(params[:q])
     @Reservations = @q.result.where(user_id: current_user).order(created_at: :desc)
     @pagy, @Reservations = pagy(@Reservations, items: 10)
    
  end

  def reserve
    @render_cart = true
    @query = Lesson.ransack(params[:q])
    @lessons_res = @query.result.includes(:category, :coach).order(dia: :asc).upcoming.disponibles
    @pagy, @lessons_res = pagy(@lessons_res)
    
  end
end
