class UserController < ApplicationController
  before_action :authenticate_user!
  
  def index
    
    # falta modulo reservas
    @mylessons = Lesson.all
  
  end

  def reserve
    @lessons = Lesson.all
  end
end
