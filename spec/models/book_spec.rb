# frozen_string_literal:true

require 'rails_helper'

RSpec.describe Book, type: :model do
  subject(:book) { build(:book) }

  describe 'Rails validations' do
    context 'when validations are needed' do
      it { is_expected.to validate_presence_of(:title) }
      it { is_expected.to validate_presence_of(:genre) }
      it { is_expected.to validate_presence_of(:language) }
      it { is_expected.to validate_presence_of(:edition) }
      it { is_expected.to validate_presence_of(:place) }
      it { is_expected.to validate_presence_of(:year) }
      it { is_expected.to validate_numericality_of(:year) }
      it { is_expected.to validate_length_of(:title).is_at_least(2).is_at_most(50) }
      it { is_expected.to validate_length_of(:genre).is_at_least(2).is_at_most(50) }
      it { is_expected.to validate_length_of(:edition).is_at_least(2).is_at_most(50) }
      it { is_expected.to validate_length_of(:place).is_at_least(2).is_at_most(50) }
    end
  end

  describe 'relationships' do
    context 'when relationships are defined' do
      it { is_expected.to belong_to(:author) }
      it { is_expected.to belong_to(:publisher) }
    end
  end

  describe 'book resources' do
    context 'when the book has the valid attributes' do
      it { expect(book).to be_valid }
    end

    context 'when the book has the invalid attributes' do
      let(:long_str) { Faker::Name.initials(number: 51) }
      let(:invalid_year) { [rand(0..1499), rand(Date.current.year.next..3000)].sample }
      let(:errors_message) { ['is too long (maximum is 50 characters)'] }

      before do
        book.update(title: long_str, genre: long_str, edition: long_str, place: long_str, year: invalid_year)
      end

      it 'generates the following errors' do
        expect(book.valid?).to be false
        expect(book.errors.messages[:title]).to eq errors_message
        expect(book.errors.messages[:genre]).to eq errors_message
        expect(book.errors.messages[:edition]).to eq errors_message
        expect(book.errors.messages[:place]).to eq errors_message
        expect(book.errors.messages[:year]).to eq ["must be in 1500..#{Date.current.year}"]
      end
    end

    context 'when the book has the null attributes' do
      let(:book) { described_class.new }
      let(:error1) { "can't be blank, is too short (minimum is 2 characters)" }
      let(:error2) { "is not a number, can't be blank" }

      it 'generates the following errors' do
        expect(book.valid?).to be false
        expect(book.errors.messages[:title].join(', ')).to eq error1
        expect(book.errors.messages[:genre].join(', ')).to eq error1
        expect(book.errors.messages[:edition].join(', ')).to eq error1
        expect(book.errors.messages[:place].join(', ')).to eq error1
        expect(book.errors.messages[:language].join).to eq "can't be blank"
        expect(book.errors.messages[:publisher].join).to eq 'must exist'
        expect(book.errors.messages[:author].join).to eq 'must exist'
        expect(book.errors.messages[:year].join(', ')).to eq error2
      end
    end
  end
end
