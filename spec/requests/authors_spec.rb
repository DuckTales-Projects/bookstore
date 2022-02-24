# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Authors', type: :request do
  describe 'GET /authors' do
    subject(:get_index) { get authors_path }

    context 'when author exists' do
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

    context 'when author not exists' do
      before { get_index }

      it 'must return an empty JSON' do
        expect(response).to have_http_status :ok
        expect(JSON(response.body).empty?).to eq true
      end
    end
  end

  describe 'GET /authors/:id' do
    subject(:get_author) { get author_path(id) }

    context 'when authors exists' do
      let(:author) { create(:author, name: 'Alexandre Versignassi') }
      let(:id) { author.id }

      before { get_author }

      it 'returns the author' do
        expect(response).to have_http_status :ok
        expect(JSON(response.body)['name']).to eq 'Alexandre Versignassi'
      end
    end

    context 'when authors not exists' do
      let(:id) { Faker::Number.within(range: 900..1000) }
      let(:message) { "Couldn't find Author with 'id'=#{id}" }

      before { get_author }

      it 'is not found' do
        expect(response).to have_http_status :not_found
        expect(JSON(response.body)['message']).to eq message
      end
    end
  end

  describe 'POST /authors' do
    subject(:create_author) { post authors_path, params: params }

    context 'when creating a new author' do
      let(:params) { { author: attributes_for(:author) } }

      before { create_author }

      it 'must return author' do
        expect(response).to have_http_status :created
        expect(JSON(response.body)['name']).to eq params.values[0].values[0]
      end
    end

    context 'when creating a new author with invalid attributes' do
      let(:params) { { author: { name: nil } } }
      let(:message) { "Validation failed: Name can't be blank" }

      before { create_author }

      it 'is a unprocessable entity' do
        expect(response).to have_http_status :unprocessable_entity
        expect(JSON(response.body)['message']).to eq message
      end
    end

    context 'when creating a new author with invalid params' do
      let(:params) { {} }

      before { create_author }

      it 'is a bad request' do
        expect(response).to have_http_status :bad_request
        expect(JSON(response.body)['message']).to eq 'param is missing or the value is empty: author'
      end
    end
  end

  describe 'PUT /authors/:id' do
    subject(:update_author) { put author_path(id), params: params }

    let(:params) { { author: { name: 'George Orwell' } } }
    let(:author) { create(:author) }
    let(:id) { author.id }

    context 'when authors exists' do
      before { update_author }

      it 'updates the author' do
        author.reload

        expect(response).to have_http_status :no_content
        expect(author.name).to eq 'George Orwell'
      end
    end

    context 'when authors does not exist' do
      let(:id) { Faker::Number.within(range: 900..1000) }
      let(:message) { "Couldn't find Author with 'id'=#{id}" }

      before { update_author }

      it 'is not found' do
        expect(response).to have_http_status :not_found
        expect(JSON(response.body)['message']).to eq message
      end
    end

    context 'with invalid params' do
      let(:params) { {} }
      let(:message) { 'param is missing or the value is empty: author' }

      before { update_author }

      it 'is a bad request' do
        expect(response).to have_http_status :bad_request
        expect(JSON(response.body)['message']).to eq message
      end
    end

    context 'with invalid attributes' do
      let(:params) { { author: { name: nil } } }
      let(:message) { "Validation failed: Name can't be blank" }

      before { update_author }

      it 'ia a unprocessable entity' do
        expect(response).to have_http_status :unprocessable_entity
        expect(JSON(response.body)['message']).to eq message
      end
    end
  end

  describe 'DELETE /authors/:id' do
    subject(:delete_author) { delete author_path(id) }

    context 'when author exists' do
      let(:author) { create(:author) }
      let(:id) { author.id }

      before { delete_author }

      it 'delete the author' do
        expect(response).to have_http_status :ok
        expect(JSON(response.body)['message']).to eq "#{author.name} was deleted"
      end
    end

    context 'when the author does not exists' do
      let(:id) { Faker::Number.within(range: 900..1000) }
      let(:message) { "Couldn't find Author with 'id'=#{id}" }

      before { delete_author }

      it 'is not found' do
        expect(response).to have_http_status :not_found
        expect(JSON(response.body)['message']).to eq message
      end
    end
  end
end
