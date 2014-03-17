class AccountMailer < ActionMailer::Base
  default from: "no-reply@calendo.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.account_mailer.register_confirmation.subject
  #
  def register_confirmation(account, user)
    @account = account
    @user = user

    mail to: @user.email, subject: "Calendo | Account registration confirmation"
  end
end
