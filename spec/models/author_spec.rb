# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Author, type: :model do
  it 'author registration' do
    author = described_class.new(name: 'John')
    expect(author.name).to eq('John')
  end

  it 'author needs a name' do
    expect(described_class.new).not_to be_valid
  end
end
