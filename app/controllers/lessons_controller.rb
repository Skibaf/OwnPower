
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

  # POST /lessons or /lessons.json
  
  def import
    
     
    # redirect if bad data
      #file = params[:file]
      #return redirect_to import_csv_lessons_path, alert: 'No file selected' unless file
      #return redirect_to import_csv_lessons_path, alert: 'Please select CSV file instead' unless file.content_type == 'text/csv'
      return redirect_to request.referer, notice: 'No file added' if params[:file].nil?
      return redirect_to request.referer, notice: 'Only CSV files allowed' unless params[:file].content_type == 'text/csv'

   # import data
      #csvImportService = CsvImportService.new(file)
      #csvImportService.import
      
      result = CsvImportService.new.import(params[:file])
      if result[:errors].empty?
        redirect_to request.referer, notice: "#{result[:count]} records imported successfully."
      else
        redirect_to request.referer, notice: result[:errors].join('. ')
        #render 'import_csv'
      end
    
    # redirect with notice
    #redirect_to lessons_path,
    #notice: "#{csvImportService.number_imported_with_last_run}  imported"
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
