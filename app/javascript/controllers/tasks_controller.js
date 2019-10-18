import { Controller } from "stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  static targets = [ "task" ]

  connect() {
    let tasksController = this;

    this.subscription = consumer.subscriptions.create("TaskChannel", {
      connected() {
      },
      received( { task } ) {
        tasksController.renderTask(task);
      }
    });
  }

  disconnect() {
    this.subscription.unsubscribe();
  }

  renderTask(taskHtml) {
    this.element.insertAdjacentHTML("afterbegin", taskHtml)
    // this.element.scrollIntoView();
  }

}
