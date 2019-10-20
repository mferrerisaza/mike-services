import { Controller } from "stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  static targets = [ "card" ]

  connect() {
    let koalaController = this;

    this.subscription = consumer.subscriptions.create("KoalaChannel", {
      connected() {
        console.log("Conectado a cel de capo")
        this.perform("prueba");
      },
      received(data) {
        console.log(data);
      }
    });
  }

  disconnect() {
    this.subscription.unsubscribe();
  }

}
