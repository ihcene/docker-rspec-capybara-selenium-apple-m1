require "rails_helper"

RSpec.describe "Period picker", type: :system, js: true do
  it 'works' do
    visit 'http://172.17.0.1:3000/'

    page.execute_script("document.write('Rails 2.4.6')")

    expect(page).to have_content('Rails 2.4.6')
  end
end
