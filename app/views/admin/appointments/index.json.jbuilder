json.array!(@appointments) do |appointment|
  json.id appointment.id
  json.text appointment.id
  json.start_date appointment.start.strftime('%Y-%m-%d %H:%M %Z')
  json.end_date appointment.end.strftime('%Y-%m-%d %H:%M %Z')
  json.customer_profile_id appointment.customer_profile_id
  json.customer_name appointment.customer_profile.user.display_name  
  json.unit_id appointment.user_id
  json.service_ids appointment.schedulables.map { |s| s.service_id}.join ',' 
end