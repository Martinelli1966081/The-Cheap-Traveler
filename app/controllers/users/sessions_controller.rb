class Users::SessionsController < Devise::SessionsController
  def create
    super
  rescue => e
    flash[:alert] = "Si è verificato un errore durante il login: #{e.message}"
    redirect_to new_user_session_path
  end

  def after_sign_out_path_for(_resource_or_scope)
    new_user_session_path
  end

  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || root_path
  end
end
