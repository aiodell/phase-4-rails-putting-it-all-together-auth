class ApplicationController < ActionController::API
  include ActionController::Cookies

  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_error
  before_action :authorize

  private

  # determine if the current user logging in matches the information
  def authorize
    @current_user = User.find_by(id: session[:user_id])
		return render json: { error: "Not authorized" }, status: :unauthorized unless @current_user
	end

  def render_unprocessable_entity_error(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end
end
