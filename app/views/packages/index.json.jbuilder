json.array!(@packages) do |package|
  json.extract! package, :id, :tittle, :description, :src_lat, :src_lon, :dest_lat, :dest_lon, :delivered, :user
  json.url package_url(package, format: :json)
end
