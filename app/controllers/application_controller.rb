class ApplicationController < ActionController::Base
   include Pagy::Backend

    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :initialize_cart
    before_action :set_render_cart
    
    

    protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username,:email,  :fisrt_name, :last_name, :role])
      devise_parameter_sanitizer.permit(:account_update, keys: [:email, :fisrt_name, :last_name, :role, :avatar])
      
    end
    
    #inicializa el carrito
    def initialize_cart
    @cart ||= Cart.find_by(id: session[:cart_id])

      if @cart.nil?
         @cart = Cart.create
         session[:cart_id] = @cart.id
      end
    end
   
    #controla sonde se mostrara el carrrito de compras
    def set_render_cart
      @render_cart = false
    end
end
