import { Controller } from "stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  static targets = [ "team", "footer", "addPapersLink", "player", "missingPlayersWarning" ]

  connect() {
    let playersController = this;

    this.subscription = consumer.subscriptions.create("PlayerChannel", {
      received( { action, player, teamId, playerId, icon } ) {
        switch (action) {
          case "add_player":
            playersController.addPlayer(player, teamId);
            break;
          case "change_player_status":
            playersController.changePlayerStatus(icon, playerId);
            break;
          case "game_restart":
            playersController.deletePlayerCookies();
            break;
        }
      }
    });
  }

  addPlayer(player, teamId) {
    const playerTeam = this.teamTargets.filter((team) => parseInt(team.dataset.id, 10) === teamId)[0];
    playerTeam.querySelector(".list-group").insertAdjacentHTML("beforeend", player);
  }

  changePlayerStatus(icon, playerId) {
    const player = this.playerTargets.filter((player) => parseInt(player.dataset.id, 10) === playerId)[0];
    player.querySelector("i").outerHTML = icon;
    if (this.playersReady() && this.teamsReady()) {
      console.log("lo tenemo")
    }
  }

  playersReady() {
    let playersReady = 0;
    this.playerTargets.forEach((player) => {
      if(player.querySelector("i").classList.contains("em-white_check_mark")) {
        playersReady ++;
      }
    });

    return playersReady === this.playerTargets.length ? true : false;
  }

  deletePlayerCookies() {
    document.cookie = 'player=;expires=Thu, 01 Jan 1970 00:00:01 GMT;';
    Turbolinks.visit("/");
  }

  teamsReady() {
    let teamsReady = 0;
    this.teamTargets.forEach((team) => {
      const teamPlayers = team.querySelectorAll(".list-group > li").length
      if (teamPlayers >= 2) {
        teamsReady ++;
      }
    })

    return teamsReady === 2 ? true : false;
  }

  clearForm() {
    this.footerTarget.innerHTML = this.addPapersLinkTarget.innerHTML;
  }

  disconnect() {
    this.subscription.unsubscribe();
  }

}
