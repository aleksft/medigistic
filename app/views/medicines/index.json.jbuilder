json.array!(@medicines) do |medicine|
  json.extract! medicine, :id, :name, :description, :expiration, :user_id
  json.url medicine_url(medicine, format: :json)
end
