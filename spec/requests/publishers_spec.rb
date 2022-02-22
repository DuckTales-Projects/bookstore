# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Publishers', type: :request do
  describe 'GET /publishers' do
    subject(:get_index) { get publishers_path }

    context 'when publisher exists' do
      let(:list) { create_list(:publisher, 9) }
      let(:publisher) { create(:publisher, name: 'Pearson') }

      before do
        list
        publisher
        get_index
      end

      it 'returns all the publishers' do
        expect(response).to have_http_status :ok
        expect(JSON(response.body).size).to eq 10
        expect(JSON(response.body).last['name']).to eq 'Pearson'
      end
    end

    context 'when the publisher does not exist' do
      before { get_index }

      it 'must return a empty JSON' do
        expect(response).to have_http_status :ok
        expect(JSON(response.body).empty?).to eq true
      end
    end
  end
end
