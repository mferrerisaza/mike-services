require("@rails/ujs").start()
require("channels")

import "bootstrap";
import "../components/papelitos.js"
import "../components/playerTurn.js"
import "controllers"


window.vapidPublicKey = new Uint8Array(<%= Base64.urlsafe_decode64(ENV['VAPID_PUBLIC_KEY']).bytes %>);


if (navigator.serviceWorker) {
  navigator.serviceWorker.register('/service-worker.js', { scope: './' })
    .then(function(reg) {
      console.log('[Companion]', 'Service worker registered!');
      console.log(reg);
    });
}

Notification.requestPermission().then((result) => {})
