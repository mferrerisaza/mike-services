import Rails from '@rails/ujs';
import Turbolinks from 'turbolinks';
import "bootstrap";
import "controllers"
import "channels"

Rails.start();
Turbolinks.start();

if (navigator.serviceWorker) {
  navigator.serviceWorker.register('/service-worker.js', { scope: './' })
    .then(function(reg) {
      console.log('[Companion]', 'Service worker registered!');
      console.log(reg);
    });
}
