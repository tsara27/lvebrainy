class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def is_xhr_admin?
    request.xhr? ? false : "admin_layout"
  end
end
