feature 'new link' do
  scenario 'creates a new link with form' do
    visit '/links/new'
    fill_in :title, with: 'Makers Academy'
    fill_in :url, with: 'http://www.makersacademy.com'
    click_button 'Submit'
    visit '/links'
    expect(page).to have_content('Makers Academy')
  end
end
