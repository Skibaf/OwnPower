require 'csv'

class CsvImportService
  
  def import(file)
    errors = []
    count = 0
    
    opened_file = File.open(file)
    options = { headers: true, col_sep: ',' }
    
    CSV.foreach(opened_file, **options) do |row|
      
      lesson_hash = {
        coach_id: User.find_by(username: row['coach'])&.id,
        category_id: Category.find_by(title: row['category'])&.id,
        precio: row['precio'],
        status: row['status'],
        dia: row['dia'],
        inicio: row['inicio'],
        fin: row['fin']
      }
      
      lesson = Lesson.new(lesson_hash)
      
      if lesson.save
        count += 1
      else
        errors << "Error importing lesson at line #{opened_file.lineno}: #{lesson.errors.full_messages.join(', ')}"
      end
    end
    
    { count: count, errors: errors }
  end

end



