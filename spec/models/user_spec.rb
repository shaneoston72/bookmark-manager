describe User do

  let!(:user) do
    User.create(name: 'Shane', email: 'test@test.com', password: 'test1234',
                password_confirmation: 'test1234')
  end

  it 'authenticates when given a valid email and password' do
    authenticated_user = User.authenticate(user.email, user.password)
    expect(authenticated_user).to eq user
  end

  it 'fails authenticate when given an invalid password' do
    expect(User.authenticate(user.email, 'wrong_password')).to be_nil
  end
  
end
