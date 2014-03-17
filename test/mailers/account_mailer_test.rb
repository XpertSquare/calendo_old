require 'test_helper'

class AccountMailerTest < ActionMailer::TestCase
  test "register_confirmation" do
    mail = AccountMailer.register_confirmation
    assert_equal "Register confirmation", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
