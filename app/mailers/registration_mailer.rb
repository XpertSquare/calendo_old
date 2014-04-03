class RegistrationMailer < ActionMailer::Base
  default from: "no-reply@calendohq.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.account_mailer.register_confirmation.subject
  #
  def registration_confirmation(registration)
    @registration = registration
    
    mail to: @registration.registrar_email, subject: "Calendo | Account registration confirmation"
  end
end