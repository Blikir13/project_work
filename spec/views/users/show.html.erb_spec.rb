require 'rails_helper'

RSpec.describe 'users/show', type: :view do
  before(:each) do
    assign(:user, User.create!(
                    username: 'Username',
                    user_mail: 'UserMail@mail.com',
                    password: 'User Password'
                  ))
  end
end
