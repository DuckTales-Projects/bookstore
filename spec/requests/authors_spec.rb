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

  describe 'POST /books' do
    context 'when creating a new author' do
      let(:params) { { author: attributes_for(:author) } }

      before { post authors_path, params: params }

      it 'must return author' do
        expect(response).to have_http_status :created
        expect(JSON(response.body)['name']).to eq params.values[0].values[0]
      end
    end

    context 'when creating a new author with invalid attributes' do
      let(:invalid_attributes) { { author: attributes_for(:author, name: nil) } }
      let(:message) { "Validation failed: Name can't be blank" }

      before { post authors_path, params: invalid_attributes }

      it 'is a unprocessable entity' do
        expect(response).to have_http_status :unprocessable_entity
        expect(JSON(response.body)['message']).to eq message
      end
    end

    context 'when creating a new author with invalid params' do
      before { post authors_path, params: {} }

      it 'is a bad request' do
        expect(response).to have_http_status :bad_request
        expect(JSON(response.body)['message']).to eq 'param is missing or the value is empty: author'
      end
    end
  end

  describe 'PUT /authors/:id' do
    let(:params) { { author: { name: 'George Orwell' } } }
    let(:author) { create(:author) }

    context 'when authors exists' do
      before { put author_path(author.id), params: params }

      it 'updates the author' do
        author.reload

        expect(response).to have_http_status :no_content
        expect(author.name).to eq 'George Orwell'
      end
    end

    context 'when authors does not exist' do
      let(:invalid_id) { Faker::Number.within(range: 900..1000) }
      let(:message) { "Couldn't find Author with 'id'=#{invalid_id}" }

      before { put author_path(invalid_id), params: params }

      it 'is not found' do
        expect(response).to have_http_status :not_found
        expect(JSON(response.body)['message']).to eq message
      end
    end

    context 'with invalid params' do
      let(:message) { 'param is missing or the value is empty: author' }

      before { put author_path(author.id), params: {} }

      it 'is a bad request' do
        expect(response).to have_http_status :bad_request
        expect(JSON(response.body)['message']).to eq message
      end
    end

    context 'with invalid attributes' do
      let(:invalid_attributes) { { author: { name: nil } } }
      let(:message) { "Validation failed: Name can't be blank" }

      before { put author_path(author.id), params: invalid_attributes }

      it 'ia a unprocessable entity' do
        expect(response).to have_http_status :unprocessable_entity
        expect(JSON(response.body)['message']).to eq message
      end
    end
  end
end
