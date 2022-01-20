# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Publisher, type: :model do
  it 'publisher registration' do
    publisher = described_class.new(name: 'Intrínseca')
    expect(publisher.name).to eq('Intrínseca')
  end

  it 'publisher needs a name' do
    expect(described_class.new).not_to be_valid
  end
end
