import { Controller } from "stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  static targets = [ "team", "footer", "addPapersLink", "player", "round1Link", "round2Link", "round3Link", "newGameLink" ]

  connect() {
    let playersController = this;

    this.subscription = consumer.subscriptions.create("PlayerChannel", {
      received( { action, player, teamId, playerId, icon, teamPoints } ) {
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
          case "block_button":
            playersController.blockBtn();
            break;
          case "unblock_button":
            playersController.unblockBtn();
            break;
          case "add_points_to_team":
            playersController.addPointsToTeam(teamId, teamPoints);
            break;
          case "remove_round1_button":
            playersController.changeFooterContent(playersController.round2LinkTarget.innerHTML);
            break;
          case "remove_round2_button":
            playersController.changeFooterContent(playersController.round3LinkTarget.innerHTML);
            break;
          case "remove_round3_button":
            playersController.changeFooterContent(playersController.newGameLinkTarget.innerHTML);
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
      this.footerTarget.innerHTML = this.round1LinkTarget.innerHTML;
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

  blockBtn() {
    this.footerTarget.querySelector(".order-more-button").classList.add("disabled");
  }

  unblockBtn() {
    this.footerTarget.querySelector(".order-more-button").classList.remove("disabled");
  }

  addPointsToTeam(teamId, teamPoints) {
    const team = this.teamTargets.filter((team) => parseInt(team.dataset.id, 10) === teamId)[0];
    const text = teamPoints > 1 ? `(${teamPoints} Puntos )` : `(${teamPoints} Punto )`;
    team.querySelector(".team-points").innerHTML = text;
  }

  changeFooterContent(newHTML) {
    this.footerTarget.innerHTML = newHTML;
  }

  disconnect() {
    this.subscription.unsubscribe();
  }

}
