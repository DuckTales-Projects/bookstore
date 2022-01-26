# frozen_string_literal:true

require 'rails_helper'

RSpec.describe Book, type: :model do
  subject(:default) { build(:book) }

  context 'with shoulda-matchers validations' do
    it { is_expected.to define_enum_for(:language).with_values(portuguese: 0, english: 1, spanish: 2) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:author) }
    it { is_expected.to validate_presence_of(:publisher) }
    it { is_expected.to validate_presence_of(:genre) }
    it { is_expected.to validate_presence_of(:language) }
    it { is_expected.to validate_presence_of(:edition) }
    it { is_expected.to validate_presence_of(:place) }
    it { is_expected.to validate_presence_of(:year) }
  end

  context 'when the book have the default attributes' do
    it { expect(default).to be_valid }

    it 'must be valid' do
      default.language = :spanish
      book = default
      expect(book).to be_valid
    end
  end

  context 'when the book does not have the default attributes' do
    it 'not to be valid' do
      default.language = nil
      book = default
      expect(book).not_to be_valid
    end

    it 'must not save the book' do
      default.language = nil
      book = default
      expect(book.save).to be false
    end
  end
end
