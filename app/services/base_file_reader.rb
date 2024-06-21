class BaseFileReader
  def initialize(file_path)
    @file_path = file_path
    @data = { headers: [], rows: [] }
  end

  def call
    raise NotImplementedError, 'Subclasses must implement a call method'
  end
end
