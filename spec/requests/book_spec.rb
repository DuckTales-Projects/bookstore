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
      let(:my_book) { create(:book) }

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

  describe 'POST #create' do
    let(:author) { create(:author) }
    let(:publisher) { create(:publisher) }

    context 'when creating' do
      let(:attributes) do
        {
          book: attributes_for(
            :book,
            author_id: author.id,
            publisher_id: publisher.id
          )
        }
      end

      before { post books_path, params: attributes }

      it 'must return my book' do
        expect(response).to have_http_status :created
        expect(JSON(response.body)['title']).to eq attributes.values[0].values[0]
        expect(JSON(response.body)['genre']).to eq attributes.values[0].values[1]
      end
    end

    context 'when creating with invalid attributes' do
      let(:invalid_attributes) { { book: attributes_for(:book, author_id: nil, publisher_id: nil) } }

      before { post books_path, params: invalid_attributes }

      it 'invalid or null parameters' do
        expect(response).to have_http_status :unprocessable_entity
        expect(JSON(response.body)['message']).to eq 'invalid or null parameters'
      end
    end

    context 'when creating with empty attributes' do
      before { post books_path, params: {} }

      it 'bad request' do
        expect(response).to have_http_status :bad_request
        expect(JSON(response.body)['message']).to eq 'invalid or null parameters'
      end
    end
  end

  describe 'PUT #update' do
    let(:attributes) { { book: attributes_for(:book) } }
    let(:my_book) { create(:book) }

    context 'when book exist' do
      before { put book_path(my_book.id), params: attributes }

      it 'uptade book' do
        expect(response).to have_http_status :ok
        expect(JSON(response.body)['title']).to eq attributes.values[0].values[0]
      end
    end

    context 'when book not exist' do
      let(:invalid_id) { Faker::Number.within(range: 900..1000) }

      before { get book_path(invalid_id), params: attributes }

      it 'is not to be found' do
        expect(response).to have_http_status :not_found
        expect(JSON(response.body)['message']).to eq "Couldnt find Book with id=#{invalid_id}"
      end
    end

    context 'when invalid attributes' do
      let(:invalid_attributes) { { book: attributes_for(:book, title: nil) } }

      before { put book_path(my_book.id), params: invalid_attributes }

      it 'invalid or null parameters' do
        expect(response).to have_http_status :unprocessable_entity
        expect(JSON(response.body)['message']).to eq 'invalid or null parameters'
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when book exist' do
      let(:my_book) { create(:book) }

      before { delete book_path(my_book.id) }

      it 'delete my book' do
        expect(response).to have_http_status :ok
        expect(JSON(response.body)['message']).to eq "#{my_book.title} is deleted"
      end
    end

    context 'when book not exist' do
      let(:invalid_id) { Faker::Number.within(range: 900..1000) }

      before { delete book_path(invalid_id) }

      it 'is not to be found' do
        expect(response).to have_http_status :not_found
        expect(JSON(response.body)['message']).to eq "Couldnt find Book with id=#{invalid_id}"
      end
    end
  end
end
