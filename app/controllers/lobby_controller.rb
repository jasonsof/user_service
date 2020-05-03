class LobbyController < ApplicationController
  def show
    render json: { message: 'yay' }
  end
end