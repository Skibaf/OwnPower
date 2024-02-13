class UserController < ApplicationController
  before_action :authenticate_user!
  
  def index
    
    # falta modulo reservas
    @render_cart = true
    @mylessons = Lesson.all
  
  end

  def reserve
    @render_cart = true
    @lessons = Lesson.all
    
  end
   

  

  
end
