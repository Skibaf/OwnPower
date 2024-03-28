class CoachController < ApplicationController
  
  before_action :authenticate_user!
  
  def index
   
   @mylessons = Lesson.all.where(coach: current_user)
    
  end


end
