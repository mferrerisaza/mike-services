//= require rails-ujs
//= require_tree .

// document.querySelector(".btn-btn-primary").addEventListener("click", (event) => {
//   Notification.requestPermission(function(status) {
//       displayNotification()
//   });
// })

// function displayNotification() {
//   if (Notification.permission == 'granted') {
//     navigator.serviceWorker.getRegistration().then(function(reg) {
//       var options = {
//         body: 'Here is a notification body!',
//         vibrate: [100, 50, 100],
//         data: {
//           dateOfArrival: Date.now(),
//           primaryKey: 1
//         },
//         actions: [
//           {action: 'explore', title: 'Atender'},
//           {action: 'close', title: 'Ahora No'},
//         ]
//       };
//       reg.showNotification('Nueva !', options);
//     });
//   }
// }
//= require serviceworker-companion
