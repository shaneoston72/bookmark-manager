require './spec/web_helper'

feature 'user password' do
  scenario 'passwords do not match' do
    sign_up_confirm
    expect(User, :count).to eq 0
  end
end
