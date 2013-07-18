json.array!(@albums) do |album|
  json.extract! album, :album, :artist, :host, :played_on
  json.url album_url(album, format: :json)
end
