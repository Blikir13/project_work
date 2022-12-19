require 'rails_helper'

RSpec.describe 'users/edit', type: :view do
  let(:user) do
    User.create!(
      username: 'MyString',
      user_mail: 'MyString@string.ru',
      password: 'MyString'
    )
  end

  before(:each) do
    assign(:user, user)
  end

end
