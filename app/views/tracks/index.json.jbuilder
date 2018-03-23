json.array!(@tracks) do |track|
  json.extract! track, :track_number, :name, :duration, :album_id
  json.url track_url(track, format: :json)
end
