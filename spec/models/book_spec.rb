# frozen_string_literal:true

require 'rails_helper'

RSpec.describe Book, type: :model do
  it 'when the book has the default attributes' do
    book = described_class.create(
      title: 'Quem é você, Alasca?',
      author: 'John Green',
      publisher: 'Intrínseca',
      genre: 'Romance/Ficção juvenil',
      language: :portuguese,
      edition: 'primeira edição',
      place: 'Brazil',
      year: 2014
    )
    expect(book).to be_valid
  end

  it 'when the book does not have the default attributes' do
    book = described_class.create(
      title: 'Quem é você, Alasca?',
      author: 'John Green',
      publisher: 'Intrínseca',
      genre: 'Romance/Ficção juvenil',
      language: 'portuguese',
      edition: 'primeira edição',
      place: 'Brazil'
    )
    expect(book).not_to be_valid
  end

  # it 'when language is invalid' do
  #   book = described_class.create(
  #     title: 'Quem é você, Alasca?',
  #     author: 'John Green',
  #     publisher: 'Intrínseca',
  #     genre: 'Romance/Ficção juvenil',
  #     language: 'espanol',
  #     edition: 'primeira edição',
  #     place: 'Brazil',
  #     year: 2014
  #   )
  #   expect(book).not_to be_valid raise_error(ArgumentError) # descobrir como esperar um erro
  # end
end
