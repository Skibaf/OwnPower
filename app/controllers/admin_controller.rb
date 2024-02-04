class AdminController < ApplicationController
  layout 'adminpanel'
  before_action :authenticate_user!
  
  def index
  end
end
