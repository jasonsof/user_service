class SessionsController < ApplicationController
  skip_before_action :authorise_request, only: [:create]

  def create
    user = User.find_by(email: params[:email])
    return render json: { token: nil }, status: 404 unless user
    
    if user.authenticate(params[:password])
      token = JWT.encode(
        {
          user_id: user.id,
          exp: 24.hours.from_now.to_i
        },
        Rails.application.secrets.secret_key_base
      )

      render json: { token: token }
    else
      render json: { token: nil }, status: 401
    end
  end
end