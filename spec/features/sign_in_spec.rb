feature 'sign_in_spec: user sign in' do

  let(:user) do
    User.create(name: 'Shane',
                email: 'shane@shaneoston.com',
                password: 'test1234',
                password_confirmation: 'test1234')
  end

  scenario 'with the correct credentials' do
    sign_in(email: user.email, password: user.password)
    expect(page).to have_content "Welcome #{user.name}"
  end

end
