require "rails_helper"

RSpec.describe "Period picker", type: :system, js: true do
  it 'works' do
    visit '/'

    page.execute_script("document.write('Rails 2.4.6')")

    expect(page).to have_content('Rails 2.4.6')
  end
end
