# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Books', type: :request do
  describe 'GET /books' do
    subject(:get_index) { get books_path, params: page }

    let(:page) { { page: 1 } }

    context 'when books exits' do
      let(:books) { create_list(:book, 4) }
      let(:my_book) { create(:book, title: 'crash') }

      before do
        books
        my_book
        get_index
      end

      it 'returns all the books' do
        expect(response).to have_http_status :ok
        expect(JSON(response.body).size).to eq 5
        expect(JSON(response.body).first.keys.size).to eq 8
        expect(JSON(response.body).first.keys).not_to include 'created_at'
        expect(JSON(response.body).first.keys).not_to include 'updated_at'
        expect(JSON(response.body).last['title']).to eq 'crash'
        expect(Book.page.total_pages).to eq 1
      end
    end

    context 'when using pagination' do
      let(:list) { create_list(:book, 11) }

      it 'set page 1' do
        setpage(1)

        expect(page[:page]).to eq 1
        expect(response).to have_http_status :ok
        expect(JSON(response.body).size).to eq 5
        expect(Book.page.total_pages).to eq 3
      end

      it 'set page 3' do
        setpage(3)

        expect(page[:page]).to eq 3
        expect(response).to have_http_status :ok
        expect(JSON(response.body).size).to eq 1
      end
    end

    context 'when books not exits' do
      before { get_index }

      it 'must return an empty JSON' do
        expect(response).to have_http_status :ok
        expect(JSON(response.body).empty?).to be true
      end
    end
  end

  describe 'GET /books/:id' do
    subject(:get_book) { get book_path(id) }

    context 'when books exits' do
      let(:my_book) { create(:book, title: 'Sem lama não há lótus') }
      let(:id) { my_book.id }

      before { get_book }

      it 'return my book' do
        expect(response).to have_http_status :ok
        expect(JSON(response.body).keys.size).to eq 8
        expect(JSON(response.body).keys).not_to include 'created_at'
        expect(JSON(response.body).keys).not_to include 'updated_at'
        expect(JSON(response.body)['title']).to eq 'Sem lama não há lótus'
        expect(JSON(response.body)['genre']).to eq my_book.genre
        expect(JSON(response.body)['language']).to eq my_book.language
        expect(JSON(response.body)['edition']).to eq my_book.edition
        expect(JSON(response.body)['place']).to eq my_book.place
        expect(JSON(response.body)['year']).to eq my_book.year
      end
    end

    context 'when books not exits' do
      let(:id) { Faker::Number.within(range: 900..1000) }
      let(:message) { "Couldn't find Book with 'id'=#{id}" }

      before { get_book }

      it 'is not found' do
        expect(response).to have_http_status :not_found
        expect(JSON(response.body)['message']).to eq message
      end
    end
  end

  describe 'POST /books' do
    subject(:create_book) { post books_path, params: params }

    context 'when creating' do
      let(:author) { create(:author) }
      let(:publisher) { create(:publisher) }
      let(:params) { { book: attributes_for(:book, author_id: author.id, publisher_id: publisher.id) } }

      before { create_book }

      it 'must return my book' do
        expect(response).to have_http_status :created
        expect(JSON(response.body)['title']).to eq params.values[0].values[0]
        expect(JSON(response.body)['genre']).to eq params.values[0].values[1]
      end
    end

    context 'when creating with invalid attributes' do
      let(:params) { { book: attributes_for(:book) } }
      let(:message) { 'Validation failed: Author must exist, Publisher must exist' }

      before { create_book }

      it 'is a unprocessable entity' do
        expect(response).to have_http_status :unprocessable_entity
        expect(JSON(response.body)['message']).to eq message
      end
    end

    context 'when creating with invalid params' do
      let(:params) { {} }
      let(:message) { 'param is missing or the value is empty: book' }

      before { create_book }

      it 'is a bad request' do
        expect(response).to have_http_status :bad_request
        expect(JSON(response.body)['message']).to eq message
      end
    end
  end

  describe 'PUT /books/:id' do
    subject(:update_book) { put book_path(id), params: params }

    let(:params) { { book: attributes_for(:book, title: '1984') } }
    let(:my_book) { create(:book) }
    let(:id) { my_book.id }

    context 'when book exists' do
      before { update_book }

      it 'updates the book' do
        my_book.reload

        expect(response).to have_http_status :no_content
        expect(my_book.title).to eq '1984'
      end
    end

    context 'when book not exists' do
      let(:id) { Faker::Number.within(range: 900..1000) }
      let(:message) { "Couldn't find Book with 'id'=#{id}" }

      before { update_book }

      it 'is not found' do
        expect(response).to have_http_status :not_found
        expect(JSON(response.body)['message']).to eq message
      end
    end

    context 'when invalid attributes' do
      let(:params) { { book: attributes_for(:book, title: nil) } }
      let(:message) { "Validation failed: Title can't be blank, Title is too short (minimum is 2 characters)" }

      before { update_book }

      it 'is a unprocessable entity' do
        expect(response).to have_http_status :unprocessable_entity
        expect(JSON(response.body)['message']).to eq message
      end
    end

    context 'when creating with invalid params' do
      let(:params) { {} }
      let(:message) { 'param is missing or the value is empty: book' }

      before { update_book }

      it 'is a bad request' do
        expect(response).to have_http_status :bad_request
        expect(JSON(response.body)['message']).to eq message
      end
    end
  end

  describe 'DELETE /books/:id' do
    subject(:delete_book) { delete book_path(id) }

    context 'when book exists' do
      let(:my_book) { create(:book) }
      let(:id) { my_book.id }

      before { delete_book }

      it 'delete my book' do
        expect(response).to have_http_status :ok
        expect(JSON(response.body)['message']).to eq "#{my_book.title} was deleted"
      end
    end

    context 'when book not exists' do
      let(:id) { Faker::Number.within(range: 900..1000) }
      let(:message) { "Couldn't find Book with 'id'=#{id}" }

      before { delete_book }

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
