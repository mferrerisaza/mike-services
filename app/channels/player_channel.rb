class PlayerChannel < ApplicationCable::Channel
  def subscribed
    stream_from "player"
  end

  def unsubscribed
    stop_all_streams
  end

  def block_button
    ActionCable.server.broadcast "player", { action: "block_button" }
  end

  def unblock_button
    ActionCable.server.broadcast "player", { action: "unblock_button" }
  end

  def add_points_to_team(data)
    team = Team.find(data["team_id"])
    ActionCable.server.broadcast "player", { action: "add_points_to_team", teamId: team.id, teamPoints: team.points }
  end

  def change_round_button
    papers_round1 = Paper.where(count: 1).where(team: nil).size
    papers_round2 = Paper.where(count: 2).where(team: nil).size
    papers_round3 = Paper.where(count: 3).where(team: nil).size

    if papers_round3.zero? && $redis.get("button_changes").to_i == 2
      ActionCable.server.broadcast "player", { action: "remove_round3_button" }
      $redis.set("button_changes", 3)
    elsif papers_round2.zero? && $redis.get("button_changes").to_i == 1
      ActionCable.server.broadcast "player", { action: "remove_round2_button" }
      $redis.set("button_changes", 2)
    elsif papers_round1.zero?  && $redis.get("button_changes").to_i == 0
      ActionCable.server.broadcast "player", { action: "remove_round1_button" }
      $redis.set("button_changes", 1)
    end
  end
end
