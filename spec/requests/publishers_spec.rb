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

  describe 'GET /publishers/:id' do
    subject(:show_publisher) { get publisher_path(id) }

    context 'when the publisher exists' do
      let(:publisher) { create(:publisher, name: 'Bertelsmann') }
      let(:id) { publisher.id }

      before { show_publisher }

      it 'returns the publisher' do
        expect(response).to have_http_status :ok
        expect(JSON(response.body)['name']).to eq 'Bertelsmann'
      end
    end

    context 'when the publisher does not exist' do
      let(:id) { Faker::Number.within(range: 900..1000) }
      let(:message) { "Couldn't find Publisher with 'id'=#{id}" }

      before { show_publisher }

      it 'is not found' do
        expect(response).to have_http_status :not_found
        expect(JSON(response.body)['message']).to eq message
      end
    end
  end

  describe 'POST /publisher' do
    context 'when creating a publisher' do
      let(:params) { { publisher: { name: 'Wolters Kluwer' } } }

      before { post publishers_path, params: params }

      it 'must return publisher' do
        expect(response).to have_http_status :created
        expect(JSON(response.body)['name']).to eq params.values[0].values[0]
      end
    end

    context 'when creating a publisher with invalid params' do
      let(:message) { 'param is missing or the value is empty: publisher' }

      before { post publishers_path, params: {} }

      it 'is a bad request' do
        expect(response).to have_http_status :bad_request
        expect(JSON(response.body)['message']).to eq message
      end
    end

    context 'when creating a publisher with invalid attibutes' do
      let(:params) { { publisher: { name: nil } } }
      let(:message) { "Validation failed: Name can't be blank" }

      before { post publishers_path, params: params }

      it 'is an unprocessable entity' do
        expect(response).to have_http_status :unprocessable_entity
        expect(JSON(response.body)['message']).to eq message
      end
    end
  end
end
