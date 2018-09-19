if (navigator.serviceWorker) {
  navigator.serviceWorker.register('/serviceworker.js', { scope: './' })
    .then(function(reg) {
      console.log('[Companion]', 'Service worker registered!');
      })
    pushNot()
}
function pushNot(){
  navigator.serviceWorker.ready.then((serviceWorkerRegistration) => {
    serviceWorkerRegistration.pushManager
    .subscribe({
      userVisibleOnly: true,
      applicationServerKey: window.vapidPublicKey
    }).then((subscription) => {
        fetch("/notifications", {
          method: "POST",
          headers: {
            "Content-Type": "application/json"
          },
          body: JSON.stringify(subscription)
        })
        // .then(res => res.json())
        .catch(error => console.error('Error:', error))
        .then(response => console.log('Success:', response));
    })
  });
}
