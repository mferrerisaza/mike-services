class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home
  end

  def koala
    PlayingCard.destroy_all
    create_game
    @playing_cards = PlayingCard.all.order('random()')
    @cover_card= { number: "", category: "&#133;".html_safe, rule: "Click para empezar" }
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
