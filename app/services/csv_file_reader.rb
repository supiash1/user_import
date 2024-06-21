# frozen_string_literal: true

require 'csv'

# CsvFileReader reads and formats CSV files, handling errors gracefully.
class CsvFileReader < BaseFileReader
  def call
    begin
      csv_data = read_csv
      @data = format_data(csv_data)
    rescue CSV::MalformedCSVError => e
      handle_csv_error(e)
    end
    @data
  end

  private

  def read_csv
    CSV.read(@file_path, headers: true, col_sep: ',', universal_newline: true, skip_lines: /^\s*$/)
  end

  def format_data(csv_data)
    { headers: csv_data.headers, rows: csv_data.map(&:to_h) }
  end

  def handle_csv_error(error)
    puts "CSV parsing error: #{error.message}"
    @data = { headers: [], rows: [] }
  end
end
