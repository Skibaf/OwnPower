# app/services/csv_import_service.rb
require 'csv'
require 'date'
require 'time'

class CsvImportService

  def initialize(file, current_user)
    @file = file
    @user = current_user
    @errors = []
  end

  def import
    CSV.foreach(@file.path, headers: true, header_converters: :symbol, col_sep: ',') do |row|
      next if row.to_hash.values.all?(&:nil?)  # Omitir filas vacías

      category = Category.find_by(title: row[:categoria])
      unless category
        @errors << "Categoría '#{row[:categoria]}' no encontrada."
        next
      end

      begin
        dia = Date.strptime(row[:dia], '%d/%m/%y')
      rescue ArgumentError => e
        @errors << "Error en la fecha para #{row[:dia]}: #{e.message}"
        next
      end

      begin
        inicio = Time.parse(row[:inicio])
        fin = Time.parse(row[:fin])
      rescue ArgumentError => e
        @errors << "Error en el tiempo para #{row[:dia]}: #{e.message}"
        next
      end

      lesson = Lesson.new(
        dia: dia,
        inicio: inicio,
        fin: fin,
        precio: row[:precio].to_i,  # Convertir precio a entero
        category: category,
        coach: @user,  # Asigna el current_user como coach
        status: :disponible  # Por defecto
      )

      unless lesson.save
        @errors << "Error al guardar la lección para #{row[:dia]}: #{lesson.errors.full_messages.join(', ')}"
      end
    end

    @errors
  end
end
