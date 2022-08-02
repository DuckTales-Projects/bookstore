# frozen_string_literal: true

json.array! @publishers do |publisher|
  json.name publisher.name
end
