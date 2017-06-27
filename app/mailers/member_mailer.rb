class MemberMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.member_mailer.welcome.subject
  #
  def welcome(member)
    @member = member
    mail to: member.email, subject: "Welcome #{member.first_name}"  
  end
end
