require 'rails_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    assign(:users, [
      User.create!(
        username: "Username",
        user_mail: "User Mail",
        user_password: "User Password"
      ),
      User.create!(
        username: "Username",
        user_mail: "User Mail",
        user_password: "User Password"
      )
    ])
  end

  it "renders a list of users" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Username".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("User Mail".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("User Password".to_s), count: 2
  end
end
