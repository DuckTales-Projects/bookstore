# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Publishers', type: :request do
  describe 'GET /publishers' do
    subject(:get_index) { get publishers_path, params: page }

    let(:page) { { page: 1 } }

    context 'when publisher exists' do
      let(:list) { create_list(:publisher, 4) }
      let(:publisher) { create(:publisher, name: 'Pearson') }

      before do
        list
        publisher
        get_index
      end

      it 'returns all the publishers' do
        expect(response).to have_http_status :ok
        expect(JSON(response.body).size).to eq 5
        expect(JSON(response.body).first.keys.size).to eq 1
        expect(JSON(response.body).first.keys).not_to include 'created_at'
        expect(JSON(response.body).first.keys).not_to include 'updated_at'
        expect(JSON(response.body).last['name']).to eq 'Pearson'
        expect(Publisher.page.total_pages).to eq 1
      end
    end

    context 'when using pagination' do
      let(:list) { create_list(:publisher, 11) }

      it 'set page 1' do
        setpage(1)

        expect(page[:page]).to eq 1
        expect(response).to have_http_status :ok
        expect(JSON(response.body).size).to eq 5
        expect(Publisher.page.total_pages).to eq 3
      end

      it 'set page 3' do
        setpage(3)

        expect(page[:page]).to eq 3
        expect(response).to have_http_status :ok
        expect(JSON(response.body).size).to eq 1
      end
    end

    context 'when the publisher does not exist' do
      before { get_index }

      it 'must return a empty JSON' do
        expect(response).to have_http_status :ok
        expect(JSON(response.body).empty?).to be true
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
        expect(JSON(response.body).keys.size).to eq 1
        expect(JSON(response.body).keys).not_to include 'created_at'
        expect(JSON(response.body).keys).not_to include 'updated_at'
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
      let(:message) { "Validation failed: Name can't be blank, Name is too short (minimum is 5 characters)" }

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
      let(:message) { "Validation failed: Name can't be blank, Name is too short (minimum is 5 characters)" }

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

def setpage(number)
  page[:page] = number
  list
  get_index
end
