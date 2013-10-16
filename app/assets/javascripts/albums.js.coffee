$('.js-remote-image').each ->
  $img = $(this)
  artist = $img.data 'artist'
  album = $img.attr 'alt'
  $.getJSON "http://ws.audioscrobbler.com/2.0/?method=album.getinfo&api_key=62cea209dd9ce3f813f103bad5f86954&artist=#{artist}&album=#{album}&format=json", ( data ) ->
    $img.attr 'src', data.album.image[2]['#text']