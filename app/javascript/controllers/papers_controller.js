import { Controller } from "stimulus"
import { Stack } from "swing/src"

const config = {
  isThrowOut: (coordinateX, coordinateY, targetElement, throwOutConfidence) => {
    return throwOutConfidence > 0.25
  }
};

export default class extends Controller {
  static targets = [ "card", "timer"]


  connect() {
    this.addCardsToStack();
    this.startCheckingForUndeletedPapers();
    this.startTimer();
  }

  addCardsToStack() {
    this.stack = new Stack(config);

    this.cardTargets.forEach((card) => {
      this.stack.createCard(card);
    });

    this.stack.on('throwout', (event) => {
      this.updatePaper(event.target);
    });
  }

  updatePaper(paper) {
    fetch(paper.dataset.fetchUrl, {
      method: "PATCH",
      headers: {
         'Content-Type': 'application/json'
       },
      body: JSON.stringify({ paper: { team_id: parseInt(this.teamId, 10) }  })
    })
      .then(response => response.json())
      .then((data) => {
        paper.classList.add("deleted")
      });
  };

  startCheckingForUndeletedPapers() {
    setInterval(() => this.checkForUndeletedPapers(), this.checkPapersInterval);
  }

  checkForUndeletedPapers() {
    const undeletedPapers = this.cardTargets.filter((card) => !card.classList.contains("deleted")).length;
    if (undeletedPapers === 0){
      Turbolinks.visit(this.redirectUrl);
    }
  }

  startTimer(minutes = 1) {
    this.seconds = 60;
    this.mins = minutes
    this.tick();
  }

  tick() {
    const current_minutes = this.mins - 1;
    this.seconds--;
    this.timerTarget.innerHTML = current_minutes.toString() + ":" + (this.seconds < 10 ? "0" : "") + String(this.seconds);
    if( this.seconds > 0 ) {
        setTimeout(() => this.tick(), 1000);
    } else {
      Turbolinks.visit(this.redirectUrl);
    }
  }

  get teamId() {
    return this.data.get("teamId")
  }

  get fetchUrl() {
    return this.data.get("teamId")
  }

  get checkPapersInterval() {
    return this.data.get("checkPapersInterval")
  }

  get redirectUrl() {
    return this.data.get("redirectUrl")
  }
}


