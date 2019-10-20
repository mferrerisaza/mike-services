require("@rails/ujs").start()
require("channels")

import "bootstrap";
import "../components/papelitos.js"
import "../components/playerTurn.js"
import "controllers"

if (navigator.serviceWorker) {
  navigator.serviceWorker.register('/service-worker.js', { scope: './' })
    .then(function(reg) {
      console.log('[Companion]', 'Service worker registered!');
      console.log(reg);
    });
}
