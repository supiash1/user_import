# The UsersImport class imports users from a CSV file, processing each record to create User instances.
class UsersImport
  def initialize(file_reader_service = CSVFileReaderService.new(file_path))
    @file_reader_service = file_reader_service
  end

  def call
    user_data = @file_reader_service.call
    create_users(user_data)
  end

  private

  def create_users(user_data)
    results = user_data[:rows].map do |user_hash|
      user = User.new(user_hash)
      if user.save
        [user.name, 'Success']
      else
        [user.name, "Failed -  #{user.errors.full_messages.join(', ')}"]
      end
    end
    { headers: user_data[:headers] - ['password'] + ['status'], results: }
  end
end
