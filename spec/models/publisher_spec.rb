# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Publisher, type: :model do
  subject(:publisher) { build(:publisher) }

  describe 'Rails validations' do
    context 'with validations' do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_length_of(:name).is_at_least(5).is_at_most(40) }
    end
  end

  describe 'relationships' do
    context 'with relationships' do
      it { is_expected.to have_many(:authors).through(:books) }
      it { is_expected.to have_many(:books).dependent(:destroy) }
    end
  end

  describe 'publisher resources' do
    context 'when the publisher has the valid attributes' do
      it { expect(publisher).to be_valid }
    end

    context 'when the publisher has the invalid attributes' do
      let(:long_str) { Faker::Name.initials(number: 41) }

      before do
        publisher.name = long_str
        publisher.save
      end

      it 'generates the following errors' do
        expect(publisher.errors.messages[:name]).to eq ['is too long (maximum is 40 characters)']
        expect(publisher.valid?).to be false
      end
    end

    context 'when the publisher has the null attributes' do
      let(:publisher) { described_class.new }
      let(:error) { "can't be blank, is too short (minimum is 5 characters)" }

      before { publisher.save }

      it 'generates the following errors' do
        expect(publisher.errors.messages[:name].join(', ')).to eq error
        expect(publisher.valid?).to be false
      end
    end
  end
end
