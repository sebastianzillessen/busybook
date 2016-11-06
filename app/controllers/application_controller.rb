class ApplicationController < ActionController::Base
  include Authenticate

  before_action :authenticate

  rescue_from ActiveRecord::RecordNotFound, with: :handle_404

end
