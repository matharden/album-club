json.array!(@albums) do |album|
  json.extract! album, :title, :artist, :host, :played_on
  json.url album_url(album, format: :json)
end
