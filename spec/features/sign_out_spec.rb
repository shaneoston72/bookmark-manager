feature 'sign_out_spec: signing out' do

  before(:each) do
    User.create(name: 'Shane',
                email: 'test@test.com',
                password: 'test1234',
                password_confirmation: 'test1234')
  end

  scenario 'user can sign out' do
    sign_in(email: 'test@test.com', password: 'test1234')
    click_button 'Sign out'
    expect(page).to have_content 'Goodbye'
    expect(page).not_to have_content 'Welcome Shane'
  end
end
