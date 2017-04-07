class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    collections_path
  end

  def body_classes
    [controller_name, action_name].join('-')
  end

  helper_method :body_classes
end
