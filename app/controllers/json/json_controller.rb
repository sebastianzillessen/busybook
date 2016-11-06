module Json
  class JsonController < ApplicationController
    #include Authenticate

    #before_action :authenticate
    serialization_scope :view_context
  end
end