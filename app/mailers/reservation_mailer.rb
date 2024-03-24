class ReservationMailer < ApplicationMailer
    def new_reservation_email(user, reservation)
        @user = user
        @reservation = reservation
        mail(to: @user.email, subject: '¡Reserva en OwnPower Generada!')
      end 
end