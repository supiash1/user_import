require 'spec_helper'

RSpec.describe BaseFileReader do
  let(:file_path) { 'path/to/file' }
  subject(:reader) { described_class.new(file_path) }

  describe '#call' do
    it 'raises NotImplementedError' do
      expect { reader.call }.to raise_error(NotImplementedError)
    end
  end
end
