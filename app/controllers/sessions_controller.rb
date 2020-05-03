class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    return render json: { token: nil }, status: 404 unless user
    
    if user.authenticate(params[:password])
      session = UserSession.create(user: user)
      render json: { token: session.token }, status: 200
    else
      render json: { token: nil }, status: 401
    end
  end
end