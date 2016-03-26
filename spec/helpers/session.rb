module SessionHelpers

  def sign_in(email:, password:)
    visit '/sessions/new'
    fill_in :email, with: email
    fill_in :password, with: password
    click_button 'Sign in'
  end

  def sign_up(name: 'Shane',
              email: 'shane@test.com',
              password: '12345678',
              password_confirmation: '12345678')
    visit '/users'
    fill_in :name, with: name
    fill_in :password, with: password
    fill_in :password_confirmation, with: password_confirmation
    fill_in :email, with: email
    click_button 'Create'
  end

end
