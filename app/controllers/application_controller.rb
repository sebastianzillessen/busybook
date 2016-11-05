class ApplicationController < ActionController::Base
  before_action :authenticate

  rescue_from ActiveRecord::RecordNotFound, with: :handle_404


  private

  def handle_404(exception)
    logger.warn(exception)
    head :not_found
  end

  def authenticate
    authenticate_or_request_with_http_basic('realm') do |name, password|
      @user = User.find_by_name(name)
      @user and @user.validate_password(password)
    end
  end
end
