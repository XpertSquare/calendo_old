json.suggestions(@customers) do |json, customer|
  json.data customer.id
  json.value customer.display_name
  json.phone '604-123-4567'
  json.email customer.email
 end