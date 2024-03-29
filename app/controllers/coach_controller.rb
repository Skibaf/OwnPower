class CoachController < ApplicationController
  before_action :authenticate_user!

    def index
        #clases del profesor
          @mylessons = Lesson.all.where(coach: current_user)
          #clases para visualizar hoy con limite de 10
          @mylessons_hoy = @mylessons.where(dia: Date.today).limit(10)
          #clases del profesor reservadas
          @lessons_rese = @mylessons.where(status: 'reservada')
          
          @lessons_count = @mylessons.group_by_day(:dia).count
          @lessons_count_rese = @lessons_rese.group_by_day(:dia).count
        
          # Pasar los datos al view - graficos reserva vs disponsibles
          @lessons_count_chart_data = @lessons_count.map { |date, count| [date.to_s, count] }.to_h
          @lessons_count_rese_chart_data = @lessons_count_rese.map { |date, count| [date.to_s, count] }.to_h
  
          #Facturacion
          # Total facturado en el mes vigente
           @total_sales_mensual = @lessons_rese.where(dia: Date.current.beginning_of_month..Date.current.end_of_month).sum(:precio)
          # Total facturado Acumulado en el año
          @total_sales_anual = @lessons_rese.where(dia: Date.current.beginning_of_year..Date.current.end_of_year).sum(:precio)


  end
end
