class ApplicationController < ActionController::API
  before_action :authorise_request

  private
  def authorise_request
    return render json: { message: 'nay' }, status: 403 unless UserSession.exists?(token: params[:token])
  end
end
