class Members::RegistrationsController < Devise::RegistrationsController
  def create
    super
    if session[:temporary_social_account].present?
      SocialAccount.find(session[:temporary_social_account]).update(:member => resource)
      session.delete(:temporary_social_account)
    end
  end

  private

  def sign_up_params
    params.require(:member).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:member).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password)
  end
end
