class Members::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @member = Member.from_omniauth(request.env["omniauth.auth"])
    if @member.persisted?
      sign_in_and_redirect @member, :event => :authentication
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_member_registration_url, alert: @member.errors.full_messages.join("\n")
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
