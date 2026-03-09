// Fly Agile Games Homepage - Main Script

(function () {
  'use strict';

  var STAR_COUNT = 40;

  function generateStars() {
    var sky = document.getElementById('sky');
    if (!sky) return;

    for (var i = 0; i < STAR_COUNT; i++) {
      var star = document.createElement('div');
      star.className = 'star';
      star.style.left = (Math.random() * 100) + '%';
      star.style.top = (Math.random() * 85) + '%';
      star.style.setProperty('--dur', (4 + Math.random() * 3) + 's');
      star.style.setProperty('--delay', (Math.random() * 7) + 's');
      sky.appendChild(star);
    }
  }

  generateStars();
})();
