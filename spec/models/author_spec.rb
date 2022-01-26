# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Author, type: :model do
  subject(:default) { build(:author) }

  context 'with shoulda-matchers validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  context 'when the author has the default attributes' do
    it 'must save the author name' do
      expect(default.save).to be true
    end
  end

  context 'when the author does not have the default attributes' do
    it 'wont be valid' do
      default.name = nil
      expect(default.valid?).to be false
    end

    it 'must not save the author name' do
      default.name = nil
      expect(default.save).to be false
    end
  end
end
