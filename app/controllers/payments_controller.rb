require 'mercadopago'
class PaymentsController < ApplicationController
  before_action :get_sdk, only: :create
  skip_before_action :verify_authenticity_token, only: :notification
  
  
    def index
         #@pagos=Payment.all
    end

   def create
          #Defino listado de productos
          orderables = @cart.orderables.includes(:lesson)
    
           items = orderables.map do |orderable|
              {
                title: "#{orderable.lesson.id} - #{orderable.lesson.category.title} - #{orderable.lesson.coach.email}",
                quantity: 1,
                currency_id: 'ARS', 
                unit_price: orderable.lesson.precio.to_f,
              }
            end
          
            external_reference = "#{current_user.id} - #{current_user.username}"

          #Genero datos para pasar a MP
          preference_data = {
            items: items,
             back_urls: {
                 success: payments_success_url,
                 failure: payments_failure_url,
                 pending: payments_pending_url
                 },
                 auto_return: 'approved',
                 notification_url: 'https://82cf-181-31-69-248.ngrok-free.app/notification',
                 external_reference: external_reference
                }
          
                #busco link para redirigir el pago
          @preference = @sdk.preference.create(preference_data)
          preference = @sdk.preference.create(preference_data)[:response]
          redirect_to preference['init_point'], allow_other_host: true
          
          
     end

        
     def success
      payment_id = params[:payment_id]
  
      # Recupera las orderables relacionadas con el payment_id
      orderables = @cart.orderables.includes(:lesson)
  
      # Crea reservas para cada orderable y cambio estado del curso
      orderables.each do |orderable|
        Reservation.create!(
          lesson_id: orderable.lesson.id,
          user_id: current_user.id, 
          payment: payment_id,
          status: 'Pagada'
        )
        orderable.lesson.update(status: :reservada)
      end
  
      # Limpia el carrito o marca los orderables como comprados según tu lógica
       @cart.orderables.destroy_all
       session[:cart] = []
  
      # Redirige a la página de éxito o a donde desees
      redirect_to root_path, notice: 'Reservas creadas exitosamente.'
    end

       def pending
          session[:cart] = []
       end

       def failure; end

       def notification
          respond_to do |format|
            format.json { head :no_content }
       end
  end

  private

        def get_sdk
          @sdk = Mercadopago::SDK.new(ENV['MERCADO_PAGO_ACCESS_TOKEN'])
          
        end
end

