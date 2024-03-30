require 'csv'

class CsvImportService
  
  def initialize(file)
    @file = file
    @count = 0
  end

  def import
    @count = 0

    CSV.foreach(@file.path, headers: true) do |row|
      lesson_params = {
        coach_id: row['coach_id'],
        category_id: Category.find_by(title: row['category_title'])&.id,
        precio: row['precio'],
        status: row['status'],
        dia: row['dia'],
        inicio: row['inicio'],
        fin: row['fin']
      }

      lesson = Lesson.new(lesson_params)
      unless lesson.save
        Rails.logger.error("Error importing lesson: #{lesson.errors.full_messages.join(', ')}")
      end
      @count  += 1
    end
  end

  def number_imported_with_last_run
    @count
  end
end



