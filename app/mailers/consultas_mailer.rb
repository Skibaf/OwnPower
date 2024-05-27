class ConsultasMailer < ApplicationMailer
  def enviar_consulta(nombre, email, mensaje)
    @nombre = nombre
    @email = email
    @mensaje = mensaje

    mail(to: 'admin@ownpower.com', subject: 'Nueva consulta desde la página de inicio')
  end
end