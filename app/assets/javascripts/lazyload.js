// This is so fithly, I'm ashamed of myself.
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

  var processScroll = function(){
    var image;
    var len = images.length;
    while(len--) {
      if (elementInViewport(images[len])) {
        image = images.splice(len, 1)[0];
        fetchAlbum(image);
        image.classList.add('loading');
      }
    };
  };

  for (var i = 0; i < query.length; i++) {
    images.push(query[i]);
  };

  processScroll();

  var timer;
  window.addEventListener('scroll', function () {
    clearTimeout(timer);
    timer = setTimeout( refresh , 150 );
  });
  var refresh = function() {
    processScroll();
  };

})();
