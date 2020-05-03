class ApplicationController < ActionController::API
  before_action :authorise_request

  private
  def authorise_request
    if request.headers['Authorization'].present?
      auth_header = request.headers['Authorization'].split(' ').last
      decoded_auth_token = JWT.decode(auth_header, Rails.application.secrets.secret_key_base).first
      current_user = User.find(decoded_auth_token['user_id'])
    else
      return render json: { message: 'missing token' }, status: 403
    end

    return render json: { message: 'nay' }, status: 403 unless current_user
  end
end
