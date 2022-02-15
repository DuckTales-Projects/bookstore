# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Books', type: :request do
  describe 'GET /index' do
    subject(:get_index) { get books_path }

    context 'when has no elements' do
      before { get_index }

      it 'must return empty json' do
        expect(response).to have_http_status :ok
        expect(response.body).to eq '[]'
      end
    end

    context 'when has elements' do
      let(:books) { create_list(:book, 9) }
      let(:my_book) { create(:book, title: Faker::Book.title) }

      before do
        books
        my_book
        get_index
      end

      it 'return all books' do
        expect(response).to have_http_status :ok
        expect(JSON.parse(response.body).size).to eq 10
        expect(JSON.parse(response.body).last['title']).to eq my_book.title
      end
    end
  end
  end
end
