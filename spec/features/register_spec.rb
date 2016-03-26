feature 'register user' do

  scenario 'I can sign up as a new user' do
    expect{ sign_up }.to change(User, :count).by 1
    expect(page).to have_content('Welcome Shane')
    expect(User.first.email).to eq 'shane@test.com'
  end

  scenario 'unmatched passwords prevent record being saved' do
    expect{ sign_up( password_confirmation: 'wrong') }.not_to change(User, :count)
    expect(current_path).to eq '/users'
  end

  scenario 'returns an error message when passwords don\'t match' do
    sign_up( password_confirmation: 'wrong')
    expect(page).to have_content 'Password does not match the confirmation'
  end

  scenario 'blank password prevents record being saved' do
    expect{ sign_up( email: nil) }.not_to change(User, :count)
    expect(current_path).to eq '/users'
    expect(page).to have_content 'You must provide a valid email address.'
  end

  scenario 'invalid email address prevents record being saved' do
    expect{ sign_up( email: 'shane.com') }.not_to change(User, :count)
    expect(current_path).to eq '/users'
    expect(page).to have_content 'Email address is formatted incorrectly.'
  end

  scenario 'cannot save a record with an existing email address' do
    2.times { sign_up }
    expect(page).to have_content 'Email address already exists.'
  end

end
