class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:email])
  end

  def new_user_registration_path(resource)
    flash[:notice] = "Signed in successfully."
  end
  def after_sign_in_path_for(resource)
    flash[:notice] = "Signed in successfully."
    user_path(current_user.id) # ログイン後に遷移するpathを設定
  end
  def after_sign_out_path_for(resource)
    flash[:notice] = "Signed out successfully."
     root_path
  end

end


