feature 'add new link' do
  scenario 'submit a link' do
    visit '/links/new'
    fill_in(:url, with: "http://www.google.com")
    fill_in(:title, with: "Google")
    click_button "submit"
    expect(current_path).to eq '/links'
    within 'ul#links' do
      expect(page).to have_content("Google")
    end
  end
end
