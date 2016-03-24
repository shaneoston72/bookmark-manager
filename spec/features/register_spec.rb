require './spec/web_helper'

feature 'register user' do
  scenario 'I can sign up as a new user' do
    expect{ sign_up }.to change(User, :count).by 1
    expect(page).to have_content('Welcome, Shane')
    expect(User.first.email).to eq 'shane@test.com'
  end
  feature 'requires maching password' do
    scenario 'passwords do not match' do
      expect{ sign_up( password_confirmation: 'wrong') }.not_to change(User, :count)
      expect(current_path).to eq '/users/new'
    end

    scenario 'returns an error message' do
      sign_up( password_confirmation: 'wrong') 
      expect(page).to have_content "Password and confirmation password do not match"
    end
  end
end
