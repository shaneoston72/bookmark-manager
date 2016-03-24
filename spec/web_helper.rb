def sign_up
  visit '/users/new'
  expect(page.status_code).to eq 200
  fill_in :name, with: 'Shane'
  fill_in :password, with: 'test1234'
  fill_in :email, with: 'test@test.com'
  click_button 'Create'
end
