import { Controller } from "stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  static targets = [ "task" ]

  connect() {
    let tasksController = this;

    this.subscription = consumer.subscriptions.create("TaskChannel", {
      received( { action, task_id, task, notification_title, notification_body } ) {
        switch (action) {
          case "create":
            tasksController.renderTask(task);
            break;
          case "update":
            tasksController.updateTask(task_id);
            break;
          case "destroy":
            tasksController.deleteTask(task_id);
            break;
        }
      }
    });
  }

  disconnect() {
    this.subscription.unsubscribe();
  }

  renderTask(taskHtml) {
    this.element.insertAdjacentHTML("afterbegin", taskHtml)
  }

  updateTask(taskId) {
    const task = this.element.querySelector(`[data-id='${taskId}']`);
    task.classList.toggle("tachado");

    if (task.classList.contains("tachado")){
      task.querySelector(".complete-task-btn").innerText = "Deshacer"
    } else {
      task.querySelector(".complete-task-btn").innerText = "Completar"
    }
  }

  deleteTask(taskId) {
    this.element.querySelector(`[data-id='${taskId}']`).remove();
  }

}
