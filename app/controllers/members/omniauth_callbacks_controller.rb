class Members::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @member = Member.from_omniauth(request.env["omniauth.auth"])
    if @member.email.blank?
      social_account = SocialAccount.create(:provider => request.env["omniauth.auth"].provider, :uid => request.env["omniauth.auth"].uid)
      session[:temporary_social_account] = social_account.id
      flash[:notice] = "Please finish your registration"
      render 'devise/registrations/new'
    else
      if @member.persisted?
        sign_in_and_redirect @member, :event => :authentication
        set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
      end
    end
  end

  def google_oauth2
    @member = Member.from_omniauth(request.env["omniauth.auth"])
    if @member.persisted?
      sign_in_and_redirect @member, :event => :authentication
      set_flash_message(:notice, :success, :kind => "Google Plus") if is_navigational_format?
    else
      session['devise.google_data'] = request.env['omniauth.auth'].except(:extra)
      redirect_to new_member_registration_url, alert: @member.errors.full_messages.join("\n")
    end
  end

  def failure
    redirect_to members_root_path
  end
end
