class SessionsController < ApplicationController
  skip_before_action :authorise_request, only: [:create]

  def create
    user = User.find_by(email: params[:email])
    return render json: { token: nil }, status: 404 unless user
    
    if user.authenticate(params[:password])
      session = UserSession.create(user: user)
      render json: { token: session.token }
    else
      render json: { token: nil }, status: 401
    end
  end
end