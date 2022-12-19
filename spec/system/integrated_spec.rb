require 'rails_helper'

RSpec.describe 'Static content', type: :system do
  scenario 'sign in and login new user' do
    visit main_path
    find('#reg').click
    fill_in :user_username, with: 'Test'
    fill_in :user_user_mail, with: 'Test@test.test'
    fill_in :user_password, with: 'Test'
    fill_in :user_password_confirmation, with: 'Test'
    find('#reguser').click
    sleep(0.5)
    expect(current_path).to eq('/en')
    visit session_login_path
    fill_in :username, with: 'Test'
    fill_in :password, with: 'Test'
    find('#loguser').click
    sleep(0.5)
    expect(current_path).to eq('/en')
  end

  scenario 'uncorrect sign in' do
    visit main_path
    find('#reg').click
    fill_in :user_username, with: 'Test'
    fill_in :user_user_mail, with: 'Test@testtest'
    fill_in :user_password, with: 'Test'
    fill_in :user_password_confirmation, with: 'Test'
    find('#reguser').click
    sleep(0.5)
    expect(current_path).to eq("/en#{new_user_path}")
    expect(find('#regres')).to have_text('Uncorrected format of email, it should be: santa@christams.gift')
  end

  scenario 'create_room' do
    visit main_path
    find('#reg').click
    fill_in :user_username, with: 'Test1'
    fill_in :user_user_mail, with: 'Test1@test.test'
    fill_in :user_password, with: 'Test1'
    fill_in :user_password_confirmation, with: 'Test1'
    find('#reguser').click
    sleep(0.5)
    find('#btn_quit').click
    # Регистрация 1 тестера
    find('#reg').click
    fill_in :user_username, with: 'Test2'
    fill_in :user_user_mail, with: 'Test2@test.test'
    fill_in :user_password, with: 'Test2'
    fill_in :user_password_confirmation, with: 'Test2'
    find('#reguser').click
    sleep(0.5)
    expect(current_path).to eq('/en')
    # Регситрация 2 тестера
    visit 'rooms/createroom'
    fill_in :room_room_name, with: 'TestRoom'
    fill_in :room_password, with: 'TestRoom'
    fill_in :room_password_confirmation, with: 'TestRoom'
    fill_in :room_count_of_users, with: '5'
    fill_in :room_real_username, with: 'Тестер второй'
    fill_in :room_wish, with: 'New computer'
    find('#btn_createroom').click
    sleep(1)
    expect(current_path).to eq('/en/main_room/showroom')
    find('#btn_back_from_room').click
    find('#link_back_from_profile').click
    # Создание комнаты и выход на глвную
    find('#btn_send_invite').click
    fill_in :n, with: 'Test1'
    find('#btn_find_user').click
    find('#link_to_user').click
    find('#btn_send_invite_room').click
    sleep(0.5)
    expect(current_path).to eq('/en')
    expect(find('#notice_main')).to have_text('User get your invite')
    # Отправление приглашения 1 тестеру
    find('#btn_quit').click
    visit session_login_path
    fill_in :username, with: 'Test1'
    fill_in :password, with: 'Test1'
    find('#loguser').click
    find('#btn_show_profile').click
    find('#btn_accept_invite').click
    fill_in :real_username, with: 'Тестер первый'
    fill_in :wish, with: 'New proccesor'
    find('#btn_accept_invite_after_info').click
    # Заход в комнату 1 тестера, комната с 2 юзерами
    find('#btn_back_from_room').click
    find('#link_back_from_profile').click
    find('#btn_quit').click
    find('#reg').click
    fill_in :user_username, with: 'Test3'
    fill_in :user_user_mail, with: 'Test3@test.test'
    fill_in :user_password, with: 'Test3'
    fill_in :user_password_confirmation, with: 'Test3'
    find('#reguser').click
    find('#btn_join_room').click
    fill_in :room_name, with: 'TestRoom'
    fill_in :password, with: 'TestRoom'
    fill_in :real_username, with: 'Тестер третий'
    fill_in :wish, with: 'More memmory'
    find('#btn_join').click
    # Создание 3 тестера и вход его через главную без приглашения
    find('#btn_back_from_room').click
    find('#link_back_from_profile').click
    find('#btn_quit').click
    visit session_login_path
    fill_in :username, with: 'Test2'
    fill_in :password, with: 'Test2'
    find('#loguser').click
    sleep(3)
    find('#btn_show_profile').click
    find('#link_to_show_room').click
    sleep(5)
    find('#btn_lottery').click
    # Проведение розыгрыша
    sleep(5)
  end
end
