listTracks = (tracks) ->
  tracks.map (track) ->
    "<li>#{track.name}</li>"

window.fetchAlbum = (albumImg, fn) ->

  url = 'http://ws.audioscrobbler.com/2.0/?method=album.getinfo'

  params = '&api_key=62cea209dd9ce3f813f103bad5f86954'
  params+= '&format=json'
  params+= '&artist=' + encodeURIComponent albumImg.dataset['artist']
  params+= '&album=' + encodeURIComponent albumImg.getAttribute('alt')

  request = new XMLHttpRequest
  request.open 'GET', url + params, true

  request.onload = ->
    if @status >= 200 and @status < 400
      # Success!
      data = JSON.parse(@response)
      if data.album
        albumImg.setAttribute 'data-src', data.album.image[2]['#text']
        albumImg.parentNode.parentNode.querySelector('.tracks').innerHTML = listTracks(data.album.tracks.track).join ' '
        loadImage albumImg, fn
    else
      # We reached our target server, but it returned an error
    return

  request.onerror = ->
    # There was a connection error of some sort
    return

  request.send()
