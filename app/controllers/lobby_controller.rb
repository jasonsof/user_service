class LobbyController < ApplicationController
  def show
    if UserSession.exists?(token: params[:token])
      render json: { message: 'yay' }
    else
      render json: { message: 'nay' }, status: 403
    end
  end
end