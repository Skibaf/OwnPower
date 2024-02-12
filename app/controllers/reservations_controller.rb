class ReservationsController < ApplicationController
  def index
       @reservations=Reservation.all
  end

  def show
  end

  
  def new
    @reservation = Reservation.new
  end

  
  def edit
  end

  
  def create
    @reservation = Reservation.new(reservation_params)

    respond_to do |format|
      if @lesson.save
        format.html { redirect_to lesson_url(@lreservationn), notice: "La reserva fue  creada." }
        format.json { render :show, status: :created, location: @reservation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  
  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to lesson_url(@lesson), notice: "Reserva actualizada." }
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
      params.require(:reservation).permit(:user_id, :status)
    end
end










end
