# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Books', type: :request do
  describe 'GET /books' do
    subject(:get_index) { get books_path }

    context 'when has no books' do
      before { get_index }

      it 'must empty JSON' do
        expect(response).to have_http_status :ok
        expect(JSON(response.body).empty?).to eq true
      end
    end

    context 'when has books' do
      let(:books) { create_list(:book, 9) }
      let(:my_book) { create(:book, title: 'crash') }

      before do
        books
        my_book
        get_index
      end

      it 'return all books' do
        expect(response).to have_http_status :ok
        expect(JSON.parse(response.body).size).to eq 10
        expect(JSON.parse(response.body).last['title']).to eq 'crash'
      end
    end
  end

  describe 'GET /books/:id' do
    context 'when there is a book' do
      let(:my_book) { create(:book, title: 'Sem lama não há lótus') }

      before { get book_path(my_book.id) }

      it 'return my book' do
        expect(response).to have_http_status :ok
        expect(JSON(response.body)['id']).to eq my_book.id
        expect(JSON(response.body)['title']).to eq 'Sem lama não há lótus'
        expect(JSON(response.body)['genre']).to eq my_book.genre
        expect(JSON(response.body)['language']).to eq my_book.language
        expect(JSON(response.body)['edition']).to eq my_book.edition
        expect(JSON(response.body)['place']).to eq my_book.place
        expect(JSON(response.body)['year']).to eq my_book.year
      end
    end

    context 'when there is no book' do
      let(:invalid_id) { Faker::Number.within(range: 900..1000) }
      let(:message) { "Couldn't find Book with 'id'=#{invalid_id}" }

      before { get book_path(invalid_id) }

      it 'is not to be found' do
        expect(response).to have_http_status :not_found
        expect(JSON(response.body)['message']).to eq message
      end
    end
  end

  describe 'POST /books' do
    let(:author) { create(:author) }
    let(:publisher) { create(:publisher) }

    context 'when creating' do
      let(:params) do
        {
          book: attributes_for(
            :book,
            author_id: author.id,
            publisher_id: publisher.id
          )
        }
      end

      before { post books_path, params: params }

      it 'must return my book' do
        expect(response).to have_http_status :created
        expect(JSON(response.body)['title']).to eq params.values[0].values[0]
        expect(JSON(response.body)['genre']).to eq params.values[0].values[1]
      end
    end

    context 'when creating with invalid attributes' do
      let(:invalid_attributes) { { book: attributes_for(:book) } }

      before { post books_path, params: invalid_attributes }

      it 'invalid parameters' do
        expect(response).to have_http_status :unprocessable_entity
        expect(JSON(response.body)['message']).to eq 'Validation failed: Author must exist, Publisher must exist'
      end
    end

    context 'when creating with empty attributes' do
      before { post books_path, params: {} }

      it 'bad request' do
        expect(response).to have_http_status :bad_request
        expect(JSON(response.body)['message']).to eq 'param is missing or the value is empty: book'
      end
    end
  end

  describe 'PUT /books/:id' do
    let(:params) { { book: attributes_for(:book, title: '1984') } }
    let(:my_book) { create(:book) }

    context 'when book exist' do
      before { put book_path(my_book.id), params: params }

      it 'uptade book' do
        expect(response).to have_http_status :ok
        expect(JSON(response.body)['title']).to eq '1984'
      end
    end

    context 'when book not exist' do
      let(:invalid_id) { Faker::Number.within(range: 900..1000) }
      let(:message) { "Couldn't find Book with 'id'=#{invalid_id}" }

      before { get book_path(invalid_id), params: params }

      it 'is not to be found' do
        expect(response).to have_http_status :not_found
        expect(JSON(response.body)['message']).to eq message
      end
    end

    context 'when invalid attributes' do
      let(:invalid_attributes) { { book: attributes_for(:book, title: nil) } }
      let(:message) { "Validation failed: Title can't be blank" }

      before { put book_path(my_book.id), params: invalid_attributes }

      it 'invalid parameters' do
        expect(response).to have_http_status :unprocessable_entity
        expect(JSON(response.body)['message']).to eq message
      end
    end
  end

  describe 'DELETE /books/:id' do
    context 'when book exist' do
      let(:my_book) { create(:book) }

      before { delete book_path(my_book.id) }

      it 'delete my book' do
        expect(response).to have_http_status :ok
        expect(JSON(response.body)['message']).to eq "#{my_book.title} was deleted"
      end
    end

    context 'when book not exist' do
      let(:invalid_id) { Faker::Number.within(range: 900..1000) }
      let(:message) { "Couldn't find Book with 'id'=#{invalid_id}" }

      before { delete book_path(invalid_id) }

      it 'is not to be found' do
        expect(response).to have_http_status :not_found
        expect(JSON(response.body)['message']).to eq message
      end
    end
  end
end
