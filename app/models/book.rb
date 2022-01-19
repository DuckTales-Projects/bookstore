# frozen_string_literal:true

class Book < ApplicationRecord
  enum language: { portuguese: 'portuguese', english: 'english', spanish: 'spanish' }
  validates :title,
            :author,
            :publisher,
            :genre,
            :language,
            :edition,
            :place,
            :year, presence: true
end
