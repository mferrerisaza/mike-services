class PagesController < ApplicationController
  skip_before_action :authenticate_user!, except: :papelitos

  def home
  end

  def koala
    create_game if PlayingCard.all.size == 0
    @playing_cards = PlayingCard.all.order('random()')
    @cover_card = { number: "", category: "&#133;".html_safe, rule: "Click para empezar" }
  end

  def papelitos
    path = ""
    unless Team.all.size == 2
      path = new_team_path
    else
      path = players_path
    end
    redirect_to path
  end

  private

  def create_game
    cartas = PlayingCard::CARTAS
    ["&diams;","&hearts;","&diams;","&spades;"].each do |category|
      cartas.each do |k, v|
        PlayingCard.create!(number: k, category: category.html_safe, rule: v)
      end
    end
  end
end
