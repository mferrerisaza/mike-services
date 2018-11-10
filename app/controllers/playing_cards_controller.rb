class PlayingCardsController < ApplicationController
  skip_before_action :authenticate_user!

  def destroy
    @playing_card = PlayingCard.find(params[:id])
    # @playing_card.destroy
  end
end
