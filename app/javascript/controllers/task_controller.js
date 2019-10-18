import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "updateActions" ]

  connect() {
    const currentUserId = document.head.querySelector(`meta[name="current-user"]`).getAttribute("id");

    if(currentUserId) {
      this.showUpdateBtns()
    }
  }

  showUpdateBtns() {
    this.updateActionsTarget.classList.remove("hidden");
  }

}
