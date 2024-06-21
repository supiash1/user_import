require 'rails_helper'

RSpec.describe CsvFileReader do
  let(:file_path) { 'spec/fixtures/users.csv' }
  subject(:service) { described_class.new(file_path) }

  describe '#call' do
    it 'reads the CSV file and returns a hash with headers and rows including status, with rows as hashes' do
      result = service.call
      expect(result).to be_a(Hash)
      expect(result[:headers]).to include('name', 'password')
      expect(result[:rows]).to be_an(Array)
      expect(result[:rows].size).to eq(4)
      expect(result[:rows]).to include({ 'name' => 'Muhammad', 'password' => 'QPFJWz1343439' })
      expect(result[:rows]).to include({ 'name' => 'Maria Turing', 'password' => 'AAAfk1swods' })
      expect(result[:rows]).to include({ 'name' => 'Isabella', 'password' => 'Abc123' })
      expect(result[:rows]).to include({ 'name' => 'Axel', 'password' => '000aaaBBBccccDDD' })
    end
  end
end
