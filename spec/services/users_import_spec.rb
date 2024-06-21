# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersImport do
  describe '#call' do
    let(:file_path) { 'spec/fixtures/users.csv' }
    let(:csv_service_mock) { instance_double(CsvFileReader) }
    let(:user_data) do
      {
        headers: %w[name password],
        rows: [
          { 'name' => 'John Doe', 'password' => 'pAssword123445' },
          { 'name' => 'Jane Doe', 'password' => 'password456' }
        ]
      }
    end

    it 'processes user data and returns headers and results' do
      allow(CsvFileReader).to receive(:new).with(file_path).and_return(csv_service_mock)
      allow(csv_service_mock).to receive(:call).and_return(user_data)
      importer = UsersImport.new(csv_service_mock)
      result = importer.call
      expect(result[:headers]).to match_array(%w[name status])
      expect(result[:results]).to match_array([['John Doe', 'Success'],
                                               ['Jane Doe', 'Failed -  Password must include at least one lowercase letter, one uppercase letter, and one digit.']])
    end
    it 'processes user data in users.csv and returns headers and results' do
      importer = UsersImport.new(file_path, CsvFileReader.new(file_path))
      result = importer.call
      expect(result[:headers]).to match_array(%w[name status])
      expect(result[:results]).to match_array([['Muhammad', 'Success'],
                                               ['Maria Turing', 'Failed -  Password cannot contain three consecutive repeating characters.'],
                                               ['Isabella', 'Failed -  Password is too short (minimum is 10 characters)'],
                                               ['Axel', 'Failed -  Password cannot contain three consecutive repeating characters.']])
    end
  end
end
