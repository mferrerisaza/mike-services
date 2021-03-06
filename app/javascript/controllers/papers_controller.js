import { Controller } from "stimulus"
import consumer from "../channels/consumer"
import { Stack, Direction } from "swing/src"

const config = {
  isThrowOut: (coordinateX, coordinateY, targetElement, throwOutConfidence) => {
    return throwOutConfidence > 0.25
  },
  allowedDirections: [Direction.LEFT, Direction.RIGHT]
};

export default class extends Controller {
  static targets = [ "card", "timer"]


  connect() {
    this.subscription = consumer.subscriptions.create("PlayerChannel")
    this.addCardsToStack();
    this.startCheckingForUndeletedPapers();
    this.startTimer();
    this.blockButtonOnClients()
  }

  disconnect() {
    clearInterval(this.refreshTimer)
    this.subscription.unsubscribe();
  }

  blockButtonOnClients() {
    this.subscription.perform("block_button")
  }

  unblockButtonOnClients() {
    this.subscription.perform("unblock_button")
    Turbolinks.visit(this.redirectUrl);
  }

  broadcastPointsForTeam(teamId) {
    this.subscription.perform("add_points_to_team", { team_id: teamId })
  }

  addCardsToStack() {
    this.stack = new Stack(config);

    this.cardTargets.forEach((card) => {
      this.stack.createCard(card);
    });

    this.stack.on('throwout', (event) => {
      const teamId = event.throwDirection == Direction.LEFT ? this.teamIdLeft : this.teamIdRight;
      this.updatePaper(event.target, teamId);
    });
  }

  updatePaper(paper, teamId) {
    fetch(paper.dataset.fetchUrl, {
      method: "PATCH",
      headers: {
         'Content-Type': 'application/json'
       },
      body: JSON.stringify({ paper: { team_id: parseInt(teamId, 10) }  })
    })
      .then(response => response.json())
      .then((data) => {
        paper.classList.add("deleted")
        this.broadcastPointsForTeam(teamId);
        this.changeRoundButton();
      });
  };

  startCheckingForUndeletedPapers() {
    this.refreshTimer = setInterval(() => this.checkForUndeletedPapers(), this.checkPapersInterval);
  }

  checkForUndeletedPapers() {
    const undeletedPapers = this.cardTargets.filter((card) => !card.classList.contains("deleted")).length;
    if (undeletedPapers === 0){
      this.unblockButtonOnClients();
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
      this.unblockButtonOnClients();
    }
  }

  pointForLeftTeam() {
    this.throwCardOut(-1000)
  }

  pointForRightTeam() {
    this.throwCardOut(1000)
  }

  throwCardOut(coordinateX) {
    const topCard  = this.cardTargets.filter((card) => !card.classList.contains("deleted")).slice(-1)[0];
    const card = this.stack.getCard(topCard)
    card.throwOut(coordinateX, 0);
  }

  changeRoundButton() {
   this.subscription.perform("change_round_button");
  }

  get teamIdLeft() {
    return this.data.get("teamIdLeft")
  }

  get teamIdRight() {
    return this.data.get("teamIdRight")
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


