feature 'add tags' do
  scenario 'view tags added' do
    visit '/links/new'
    fill_in :title, with: 'Makers Academy'
    fill_in :url, with: 'http://www.makersacademy.com'
    fill_in :tags, with: 'education'
    click_button 'Submit'

    link = Link.first
    expect(link.tags.map(&:name)).to include('education')
    end
  end
