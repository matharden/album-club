/* lazyload.js (c) Lorenzo Giuliani
 * MIT License (http://www.opensource.org/licenses/mit-license.html)
 *
 * expects a list of:
 * `<img src="blank.gif" data-src="my_image.png" width="600" height="400" class="lazy">`
 */
 (function() {
  window.loadImage = function (el, fn) {
    var img = new Image();
    var src = el.getAttribute('data-src');

    img.onload = function() {
      if (!!el.parent)
        el.parent.replaceChild(img, el)
      else
        el.src = src;

      el.classList.remove('loading');
      fn? fn() : null;
    }


    img.src = src;
  }

  function elementInViewport(el) {
    var rect = el.getBoundingClientRect()

    return (
       rect.top    >= 0
    && rect.left   >= 0
    && rect.top <= (window.innerHeight || document.documentElement.clientHeight)
    )
  }

  window.images = new Array();
  window.query = document.querySelectorAll('.album img');

  window.processScroll = function(){
    var image;
    for (var i = 0; i < images.length; i++) {
      if (elementInViewport(images[i])) {
        image = images.splice(i, 1)[0];
        fetchAlbum(image);
        image.classList.add('loading');
      }
    };
  };

  for (var i = 0; i < query.length; i++) {
    images.push(query[i]);
  };

  processScroll()
  window.addEventListener('scroll', processScroll, false);

})();
