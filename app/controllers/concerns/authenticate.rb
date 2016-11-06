module Authenticate
  extend ActiveSupport::Concern
  private
  def handle_404(exception)
    logger.warn(exception)
    head :not_found
  end

  def authenticate
    logger.info("Checking authentication")
    authenticate_or_request_with_http_basic('realm') do |name, password|
      @user = User.find_by_name(name)
      @user and @user.validate_password(password)
    end
  end

  def check_authentication
    logger.info("Checking Authorization for #{@user.name}")
    head :unauthorized unless (@user)
  end

end
