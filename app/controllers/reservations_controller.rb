class ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[ show edit update destroy ]


    def index
       @Reservations = Reservation.all
        
    end

    def show
    end

    def new
      @reservation = Reservation.new
    end

    def edit
    end

    def create
      
      # Recupera las orderables relacionadas con el payment_id
      orderables = @cart.orderables.includes(:lesson)
  
      # Crea reservas para cada orderable y cambio estado del curso
      orderables.each do |orderable|
        reservation= Reservation.create!(
          lesson_id: orderable.lesson.id,
          user_id: current_user.id, 
          payment: 'Pendiente',
          status: 'Pendiente'
        )
        orderable.lesson.update(status: :reservada)
        ReservationMailer.new_reservation_email(current_user, reservation).deliver_now 
      end
  
      # Limpia el carrito o marca los orderables como comprados según tu lógica
       @cart.orderables.destroy_all
       session[:cart] = []
  
      # Redirige a la página de éxito o a donde desees
      redirect_to user_index_path, notice: 'Reservas creadas exitosamente.'

    end
    
    def edit_status
      set_reservation
    end
    
  
    def update
      respond_to do |format|
        if @reservation.update(reservation_params)
          format.html { redirect_to reservation_url(@reservation), notice: "Reserva actualizada." }
          format.json { render :show, status: :ok, location: @reservation }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @reservation.errors, status: :unprocessable_entity }
        end
      end
    end

 
    def destroy
      @reservation.destroy!

      respond_to do |format|
        format.html { redirect_to reservation_url, notice: "Reserva eliminada." }
        format.json { head :no_content }
      end
    end

    private
      
      def set_reservation
        @reservation = Reservation.find(params[:id])
      end

      
      def reservation_params
        params.require(:reservation).permit(:user_id, :status, :lesson_id, :payment)
      end
end
