# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Author, type: :model do
  subject(:author) { build(:author) }

  context 'with validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  context 'with relationships' do
    it { is_expected.to have_many(:books).dependent(:destroy) }
  end

  context 'when the author has the default attributes' do
    it 'must save the author name' do
      expect(author.save).to be true
    end
  end

  context 'when the author does not have the default attributes' do
    it 'wont be valid' do
      author.name = nil
      expect(author.valid?).to be false
      expect(author.save).to be false
    end
  end
end
