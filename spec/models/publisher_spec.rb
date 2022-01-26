# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Publisher, type: :model do
  subject(:default) { build(:publisher) }

  context 'with shoulda-matchers validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  context 'when the publisher has the default attributes' do
    it 'must save the author name' do
      expect(default.save).to be true
    end
  end

  context 'when the publisher does not have the default attributes' do
    it 'wont be valid' do
      default.name = nil
      expect(default.valid?).to be false
    end

    it 'must not save the publisher name' do
      default.name = nil
      expect(default.save).to be false
    end
  end
end
