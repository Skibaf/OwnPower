require 'mercadopago'
class PaymentsController < ApplicationController
  before_action :get_sdk, only: :create
  skip_before_action :verify_authenticity_token, only: :notification
  
  
    def index
         #@pagos=Payment.all
    end

   def create
          #Defino listado de productos
          #items2 = @cart.orderables.map { |lesson_id| Lesson.find(id) }.map(&:to_preference_item)
          
          #Genero datos para pasar a MP
          preference_data = {
            items: [{
              title: 'Reserva General',
              quantity: 1,
              currency_id: 'ARS', # Peso argentino
              unit_price: 1.0 # Monto en pesos argentinos
             }],
             back_urls: {
                 success: payments_success_url,
                 failure: payments_failure_url,
                 pending: payments_pending_url
                 },
                 auto_return: 'approved',
                 notification_url: 'https://82cf-181-31-69-248.ngrok-free.app/notification',
                 external_reference: 'reserva_general_123'
                }
          
                #busco link para redirigir el pago
          @preference = @sdk.preference.create(preference_data)
          preference = @sdk.preference.create(preference_data)[:response]
          redirect_to preference['init_point'], allow_other_host: true
          
          
     end

        
       def success
          session[:cart] = []
       
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

