require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(10).is_at_most(16) }
    it { should allow_value('Aqpfk1swods').for(:password) }
    it { should allow_value('QPFJWz1343439').for(:password) }
    it { should allow_value('PFSHH78KSMa').for(:password) }
    it { should_not allow_value('Abc123').for(:password).with_message(I18n.t('errors.messages.too_short', count: 10)) }
    it { should_not allow_value('abcdefghijklmnop').for(:password).with_message(:invalid_password_format) }
    it { should_not allow_value('AAAfk1swods').for(:password).with_message(:consecutive_repeating_characters) }
  end
end
