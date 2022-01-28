require "test_helper"

class MessageTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(username: "doe", password: "password")
    Message.delete_all
    @message = Message.create(body: "Hi dude", user: @user)
  end

  def test_body_should_be_valid
    assert @message.valid?
  end

  def test_body_should_be_present
    @message.body = " "
    assert_not @message.valid?
  end
end
