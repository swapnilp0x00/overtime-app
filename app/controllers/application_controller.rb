class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # requires user authenticated ,by devise
  before_action :authenticate_user!
end
