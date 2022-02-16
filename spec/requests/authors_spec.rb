# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Authors', type: :request do
  describe 'GET /index' do
    subject(:get_index) { get authors_path }

    context 'when author exist' do
      let(:author) { create(:author) }
      let(:list) { create_list(:author, 9) }

      before do
        author
        list
        get_index
      end

      it 'return all authors' do
        expect(response).to have_http_status :ok
        expect(JSON.parse(response.body).size).to eq 10
        expect(JSON.parse(response.body).first['name']).to eq author.name
      end
    end

    context 'when author not exist' do
      before { get_index }

      it 'empty response' do
        expect(response).to have_http_status :ok
        expect(JSON(response.body).empty?).to eq true
      end
    end
  end
end
