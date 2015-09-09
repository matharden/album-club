listTracks = (tracks) ->
  tracks.map (track) ->
    "<li>#{track.name}</li>"

$('.js-remote-image').each ->
  $img = $(this)

  $.getJSON('http://ws.audioscrobbler.com/2.0/?method=album.getinfo',
    api_key: '62cea209dd9ce3f813f103bad5f86954'
    artist: $img.data 'artist'
    album: $img.attr 'alt'
    format: 'json'
  ).done (data) ->
    if data.album
      $img.attr 'src', data.album.image[3]['#text']
      $img.closest('.album').find('.info .tracks').html listTracks(data.album.tracks.track)
    else
      $img.closest('div').addClass 'is-notfound'
