window.writeTracks = (tracks, image) ->
  image.parentNode.parentNode.querySelector('.tracks tbody').innerHTML = listTracks(tracks).join ' '

window.writeFields = (tracks) ->
  tracks.forEach (track) ->
    newFields = useTemplate()
    newFields.find("input[name$='[track_number]']").val track['@attr'].rank
    newFields.find("input[name$='[name]']").val track.name
    newFields.find("input[name$='[duration]']").val track.duration

listTracks = (tracks) ->
  tracks.map (track) ->
    """
    <tr><td>#{track['@attr'].rank}</td>
    <td>#{track.name}</td>
    <td>#{toMinutes(track.duration)}</td></tr>
    """

toMinutes = (t) ->
  m = 60
  r = t % m
  min = (t - r) / m
  min + ':' + pad(r)

pad = (n) ->
  ('00' + n).slice -2

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
        if data.album.image[2]['#text']
          albumImg.setAttribute 'data-src', data.album.image[2]['#text']
        else
          albumImg.classList.remove 'loading'
        fn data.album.tracks.track, albumImg
        loadImage albumImg
    else
      # We reached our target server, but it returned an error
    return

  request.onerror = ->
    # There was a connection error of some sort
    return

  request.send()


jQuery ->
  $('form').on 'click', '.remove_fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('fieldset').hide()
    event.preventDefault()

  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    event.preventDefault()

  getRandomInt = (max) ->
    Math.floor(Math.random() * Math.floor(max))

  window.useTemplate = (el) ->
    template = $('.fields_template')
    time = new Date().getTime()
    regexp = new RegExp(template.data('id'), 'g')
    newField = template.data('fields').replace(regexp, time + getRandomInt(9999))
    $(newField).insertBefore('.fields_template')
