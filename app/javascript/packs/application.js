import "bootstrap";
import "../components/feed.js"
import "../components/papelitos.js"
import "../components/playerTurn.js"

require("@rails/ujs").start()

if (navigator.serviceWorker) {
  navigator.serviceWorker.register('/service-worker.js', { scope: './' })
    .then(function(reg) {
      console.log('[Companion]', 'Service worker registered!');
      console.log(reg);
    });
}
