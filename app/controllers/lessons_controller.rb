
class LessonsController < ApplicationController
  
  before_action :set_lesson, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  
  # GET /lessons or /lessons.json
  def index
    @lesson = Lesson.new
    @q = Lesson.ransack(params[:q])
    @lessons = @q.result.where(coach_id: current_user).includes(:category, :coach).order(dia: :desc)
    @pagy, @lessons = pagy(@lessons, items: 15)
    
  end

  # GET /lessons/1 or /lessons/1.json
  def show
  end

  # GET /lessons/new
  def new
    @lesson = Lesson.new
    @lesson.coach_id = current_user.id
  end

  # GET /lessons/1/edit
  def edit
  end

  def buscar_lessons
    dia = params[:dia]
    

    # Lógica para establecer los valores predeterminados si no se proporcionan
    dia ||= Date.tomorrow
    

    @lessons = Lesson.por_dia(dia)

    respond_to do |format|
      format.turbo_stream
      format.html { render partial: 'user/lessons_table', locals: { lessons: @lessons } }
    end
  end

  # import de clases por parte de los profesores
  
  def import
  
      if params[:file].nil?
        return redirect_to request.referer, notice: 'No file added'
      end

      if params[:file].content_type != 'text/csv'
        return redirect_to request.referer, notice: 'Only CSV files allowed'
      end

      begin
        csv_text = File.read(params[:file].path)
        csv = CSV.parse(csv_text, headers: true, header_converters: :symbol, col_sep: ',')
        first_row = csv.first

        if first_row.nil?
          return redirect_to request.referer, notice: "El archivo CSV está vacío o no tiene un formato correcto."
        end

        flash[:notice] = "Primera fila del CSV: #{first_row.to_hash}"

        errors = CsvImportService.new(params[:file], current_user).import
        if errors.empty?
          
          redirect_to request.referer, notice: "Records importados Exitosamente."
        else
          redirect_to request.referer, alert: errors.join("\n")
        end
      rescue => e
        redirect_to request.referer, alert: "Error al leer el archivo CSV: #{e.message}"
      end
  end
  

  def create
    @lesson = Lesson.new(lesson_params)
    
    respond_to do |format|
      if @lesson.save
        format.html { redirect_to lesson_url(@lesson), notice: 'La clase se creó exitosamente.' }
        format.json { render :show, status: :created, location: @lesson }
      else
        format.html { render :new , status: :unprocessable_entity}
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end
  
  

  # PATCH/PUT /lessons/1 or /lessons/1.json
  def update
    respond_to do |format|
      if @lesson.update(lesson_params)
        format.html { redirect_to lesson_url(@lesson), notice: "La clase se actualizo ." }
        format.json { render :show, status: :ok, location: @lesson }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lessons/1 or /lessons/1.json
  def destroy
    @lesson.destroy!

    respond_to do |format|
      format.html { redirect_to lessons_url, notice: "La clase fue eliminada." }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lesson
      @lesson = Lesson.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def lesson_params
      params.require(:lesson).permit(:coach_id, :category_id, :precio, :status, :dia, :inicio, :fin)
    end
end
