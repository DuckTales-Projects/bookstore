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
        expect(JSON(response.body).size).to eq 3
        expect(JSON(response.body)['total_publishers']).to eq 10
        expect(JSON(response.body)['list'].size).to eq 10
        expect(JSON(response.body)['pagination']).to eq '0 of 1'
        expect(JSON(response.body)['list'].last['name']).to eq 'Pearson'
      end
    end

    context 'when the publisher does not exist' do
      before { get_index }

      it 'must return a empty JSON' do
        expect(response).to have_http_status :ok
        expect(JSON(response.body)['list'].empty?).to eq true
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
    subject(:create_publisher) { post publishers_path, params: params }

    context 'when creating a publisher' do
      let(:params) { { publisher: { name: 'Wolters Kluwer' } } }

      before { create_publisher }

      it 'must return publisher' do
        expect(response).to have_http_status :created
        expect(JSON(response.body)['name']).to eq params.values[0].values[0]
      end
    end

    context 'when creating a publisher with invalid params' do
      let(:params) { {} }
      let(:message) { 'param is missing or the value is empty: publisher' }

      before { create_publisher }

      it 'is a bad request' do
        expect(response).to have_http_status :bad_request
        expect(JSON(response.body)['message']).to eq message
      end
    end

    context 'when creating a publisher with invalid attibutes' do
      let(:params) { { publisher: { name: nil } } }
      let(:message) { "Validation failed: Name can't be blank" }

      before { create_publisher }

      it 'is an unprocessable entity' do
        expect(response).to have_http_status :unprocessable_entity
        expect(JSON(response.body)['message']).to eq message
      end
    end
  end

  describe 'PUT /publishers/:id' do
    subject(:update_publisher) { put publisher_path(id), params: params }

    let(:params) { { publisher: { name: 'ThomsonReuters' } } }
    let(:publisher) { create(:publisher, name: 'Bertelsmann') }
    let(:id) { publisher.id }

    context 'when the publisher exists' do
      before { update_publisher }

      it 'updates the publisher' do
        publisher.reload

        expect(response).to have_http_status :no_content
        expect(publisher.name).to eq 'ThomsonReuters'
      end
    end

    context 'when the publisher does not exist' do
      let(:id) { Faker::Number.within(range: 900..1000) }
      let(:message) { "Couldn't find Publisher with 'id'=#{id}" }

      before { update_publisher }

      it 'is not found' do
        expect(response).to have_http_status :not_found
        expect(JSON(response.body)['message']).to eq message
      end
    end

    context 'with invalid params' do
      let(:params) { {} }
      let(:message) { 'param is missing or the value is empty: publisher' }

      before { update_publisher }

      it 'is a bad request' do
        expect(response).to have_http_status :bad_request
        expect(JSON(response.body)['message']).to eq message
      end
    end

    context 'with invalid attributes' do
      let(:params) { { publisher: { name: nil } } }
      let(:message) { "Validation failed: Name can't be blank" }

      before { update_publisher }

      it 'is a unprocessable entity' do
        expect(response).to have_http_status :unprocessable_entity
        expect(JSON(response.body)['message']).to eq message
      end
    end
  end

  describe 'DELETE /publishers/:id' do
    subject(:delete_publisher) { delete publisher_path(id) }

    let(:publisher) { create(:publisher, name: 'Bertelsmann') }
    let(:id) { publisher.id }

    context 'when the publisher exists' do
      before { delete_publisher }

      it 'delete the publisher' do
        expect(response).to have_http_status :ok
        expect(JSON(response.body)['message']).to eq "#{publisher.name} was deleted"
      end
    end

    context 'when the publisher does not exist' do
      let(:id) { Faker::Number.within(range: 900..1000) }
      let(:message) { "Couldn't find Publisher with 'id'=#{id}" }

      before { delete_publisher }

      it 'is not found' do
        expect(response).to have_http_status :not_found
        expect(JSON(response.body)['message']).to eq message
      end
    end
  end
end
