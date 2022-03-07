# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Author, type: :model do
  subject(:author) { build(:author) }

  describe 'Rails validations' do
    context 'when validations are needed' do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_length_of(:name).is_at_least(3).is_at_most(20) }
    end
  end

  describe 'relationships' do
    context 'with relationships' do
      it { is_expected.to have_many(:publishers).through(:books) }
      it { is_expected.to have_many(:books).dependent(:destroy) }
    end
  end

  describe 'author resources' do
    context 'when the author has the valid attributes' do
      it { expect(author).to be_valid }
    end

    context 'when the author has the invalid attributes' do
      let(:long_str) { Faker::Name.initials(number: 21) }

      before do
        author.name = long_str
        author.save
      end

      it 'generates the following errors' do
        expect(author.errors.messages[:name]).to eq ['is too long (maximum is 20 characters)']
        expect(author.valid?).to be false
      end
    end

    context 'when the author has the null attributes' do
      let(:author) { described_class.new }
      let(:error) { "can't be blank, is too short (minimum is 3 characters)" }

      before { author.save }

      it 'generates the following errors' do
        expect(author.errors.messages[:name].join(', ')).to eq error
        expect(author.valid?).to be false
      end
    end
  end
end
