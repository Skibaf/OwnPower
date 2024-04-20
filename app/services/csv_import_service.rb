require 'csv'

class CsvImportService
  
  def import(file, current_user)
    count = 0
    errors = []
  
    CSV.foreach(file.path, col_sep: ";", headers: true) do |row|
      p row
      lesson_hash = row.to_h.transform_keys(&:downcase)
      
      #toma coach
      coach_id = current_user.id
      puts "Coach: #{coach_id}"

      #toma categoria
      category_title = lesson_hash["category"]
      puts "Category title: #{category_title}"
      category = Category.find_by(title: category_title)
      puts "category #{category}"
      precio = lesson_hash["precio"]
      puts "preciof #{precio}"
      
      if category.nil?
        errors << "Category not found for title: #{category_title}"
        next
      end
  
      lesson_hash["coach_id"] = coach_id
      lesson_hash["category_id"] = category
  
      lesson = Lesson.new(lesson_hash)
  
      if lesson.save
        count += 1
      else
        errors << "Error importing lesson: #{lesson.errors.full_messages.join(', ')}"
      end
    end
  
    { count: count, errors: errors }
  end
  
end



