class CoachController < ApplicationController
  layout 'adminpanel'
  before_action :authenticate_user!
  
  def index
   
   @lessons = Lesson.all
   @mylessons = Lesson.all.where(coach: current_user)
    
  
  end


end
