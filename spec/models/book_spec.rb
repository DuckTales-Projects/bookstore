# frozen_string_literal:true

require 'rails_helper'

RSpec.describe Book, type: :model do
  subject(:book) { build(:book) }

  context 'with shoulda-matchers validations' do
    it { is_expected.to belong_to(:author) and belong_to(:publisher) }
    it { is_expected.to define_enum_for(:language).with_values(portuguese: 0, english: 1, spanish: 2) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:genre) }
    it { is_expected.to validate_presence_of(:language) }
    it { is_expected.to validate_presence_of(:edition) }
    it { is_expected.to validate_presence_of(:place) }
    it { is_expected.to validate_presence_of(:year) }
    # add year new validations tests
  end

  context 'when the book has the default attributes' do
    it { expect(book).to be_valid }

    it 'must be valid' do
      book.language = :spanish
      expect(book).to be_valid
    end
  end

  context 'when the book does not have the default attributes' do
    it 'wont to be valid' do
      book.language = nil
      expect(book.valid?).to be false
      expect(book.save).to be false
    end
  end
end
