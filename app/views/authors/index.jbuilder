# frozen_string_literal: true

json.array! @authors do |author|
  json.name author.name
end
