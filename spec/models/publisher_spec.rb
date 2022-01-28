# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Publisher, type: :model do
  subject(:publisher) { build(:publisher) }

  context 'with shoulda-matchers validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to have_many(:books).dependent(:destroy) }
  end

  context 'when the publisher has the default attributes' do
    it 'must save the author name' do
      expect(publisher.save).to be true
    end
  end

  context 'when the publisher does not have the default attributes' do
    it 'wont be valid' do
      publisher.name = nil
      expect(publisher.valid?).to be false
      expect(publisher.save).to be false
    end
  end
end
