import { Controller } from "stimulus"
import createChannel from "cables/cable";

export default class extends Controller {
  static targets = [ "task" ]

  connect() {
    this.tasksChannel = createChannel( "TaskChannel", {
      connected() {
        console.log("conected");
      },
      received(data) {
        console.log(data);
      }


    });
  }
}
