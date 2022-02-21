# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Authors', type: :request do
  describe 'GET /authors' do
    subject(:get_index) { get authors_path }

    context 'when author exist' do
      let(:author) { create(:author, name: 'Dan Brown') }
      let(:list) { create_list(:author, 9) }

      before do
        author
        list
        get_index
      end

      it 'returns all the authors' do
        expect(response).to have_http_status :ok
        expect(JSON(response.body).size).to eq 10
        expect(JSON(response.body).first['name']).to eq 'Dan Brown'
      end
    end

    context 'when author not exist' do
      before { get_index }

      it 'must return a empty JSON' do
        expect(response).to have_http_status :ok
        expect(JSON(response.body).empty?).to eq true
      end
    end
  end

  describe 'GET /authors/:id' do
    context 'when authors exist' do
      let(:author) { create(:author, name: 'Alexandre Versignassi') }

      before { get author_path(author.id) }

      it 'returns the author' do
        expect(response).to have_http_status :ok
        expect(JSON(response.body)['name']).to eq 'Alexandre Versignassi'
      end
    end

    context 'when authors not exist' do
      let(:invalid_id) { Faker::Number.within(range: 900..1000) }
      let(:message) { "Couldn't find Author with 'id'=#{invalid_id}" }

      before { get author_path(invalid_id) }

      it 'is not found' do
        expect(response).to have_http_status :not_found
        expect(JSON(response.body)['message']).to eq message
      end
    end
  end
end
