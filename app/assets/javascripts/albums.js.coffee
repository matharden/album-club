$('.js-remote-image').each ->
  $img = $(this)
  
  $.getJSON('http://ws.audioscrobbler.com/2.0/?method=album.getinfo',
    api_key: '62cea209dd9ce3f813f103bad5f86954'
    artist: $img.data 'artist'
    album: $img.attr 'alt'
    format: 'json'
  ).done (data) ->
    if data.album
      $img.attr 'src', data.album.image[2]['#text']
    else
      $img.closest('div').addClass 'is-notfound'