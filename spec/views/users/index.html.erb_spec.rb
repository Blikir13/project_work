require 'rails_helper'

RSpec.describe 'users/index', type: :view do
  before(:each) do
    assign(:users, [
             User.create!(
               username: 'Username',
               user_mail: 'UserMail@mail.com',
               password: 'User Password'
             ),
             User.create!(
               username: 'Username1',
               user_mail: 'UserMail@mail.com',
               password: 'User Password'
             )
           ])
  end

end
