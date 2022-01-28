require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    User.delete_all
    @user = User.create!(username: "doe", password: "password")
  end

  def test_user_should_be_valid
    assert @user.valid?
  end

  def test_username_should_be_present
    @user.username = " "
    assert_not @user.valid?
  end

  def test_username_should_be_unique
    @user2 = User.new(username: "doe", password: "password")
    assert_not @user2.valid?
  end

  def test_username_should_not_be_too_long
    @user.username = "a" * 21
    assert_not @user.valid?
  end

  def test_username_should_not_be_too_short
    @user.username = "aa"
    assert_not @user.valid?
  end
end
