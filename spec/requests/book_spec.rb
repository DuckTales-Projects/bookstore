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

  describe 'GET #show' do
    context 'when there is a book' do
      let(:my_book) { create(:book) }

      before { get book_path(my_book.id) }

      it 'return my book' do
        expect(response).to have_http_status :ok
        expect(JSON(response.body)['title']).to eq my_book.title
        expect(JSON(response.body)['id']).to eq my_book.id
      end
    end

    context 'when there is no book' do
      let(:invalid_id) { Faker::Number.within(range: 900..1000) }

      before { get book_path(invalid_id) }

      it 'is not to be found' do
        expect(response).to have_http_status :not_found
        expect(JSON(response.body)['message']).to eq "Couldnt find Book with id=#{invalid_id}"
      end
    end
  end
  end
  end
end
