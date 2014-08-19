json.suggestions(@customers) do |customer|
  json.data customer.customer_profile.id
  json.value customer.display_name
  json.phone '604-123-4567'
  json.email customer.email
 end