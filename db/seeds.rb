# frozen_string_literal: true

puts '---------------------------------------'
puts 'Start "seeds"'
puts '---------------------------------------'

puts '---------- creating Authors -----------'
author = FactoryBot.create(:author, name: 'Neil Gaiman')
FactoryBot.create_list(:author, 3)

puts '---------- creating Publishers --------'
publisher = FactoryBot.create(:publisher, name: 'Intrínseca')
FactoryBot.create_list(:publisher, 3)

puts '---------- creating Books -------------'
book = FactoryBot.create(:book, title: 'Mitologia Nórdica', genre: 'Mito', place: 'Brasil', language: 'portuguese')
FactoryBot.create_list(:book, 3)

puts '---------------------------------------'
puts 'Finished "seeds"'
puts '---------------------------------------'
