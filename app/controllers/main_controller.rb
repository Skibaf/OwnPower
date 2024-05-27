class MainController < ApplicationController
  def home
  end

  def about
  end

  def enviar_consulta
    
    ConsultasMailer.enviar_consulta(params[:nombre], params[:email], params[:mensaje]).deliver_now
    
    flash[:notice] = "Tu consulta ha sido enviada exitosamente."
    redirect_to root_path
  
  end
end
