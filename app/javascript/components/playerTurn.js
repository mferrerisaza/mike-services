function selectPlayer(teamId) {
  const url = `/teams/${teamId}`
 fetch(url)
  .then(response => response.json())
  .then((data) => {
    $activePlayer = document.querySelector(`[data-player-id='${data.id}'`)
    $activePlayer.innerHTML = "Got you"
  });
}

function getTeamPlayedRounds(team) {
  let playedRounds = 0;
  for (let i = 0; i < team.players.length; i++) {
    playedRounds += team.players[i].played_rounds;
  }
  return playedRounds
}

getRandom = function (list) {
  return list[Math.floor((Math.random()*list.length))];
}

function getPlayers() {
  fetch("/teams")
  .then(response => response.json())
  .then((data) => {
    const teamOneRounds = getTeamPlayedRounds(data[0]);
    const teamTwoRounds = getTeamPlayedRounds(data[1]);
    if (teamOneRounds > teamTwoRounds){
      selectPlayer(data[1].id);
    } else if (teamOneRounds < teamTwoRounds) {
      selectPlayer(data[0].id);
    } else {
      selectPlayer(getRandom(data).id);
    }
  });
}

document.addEventListener("DOMContentLoaded", () => {
  // getPlayers();
})
