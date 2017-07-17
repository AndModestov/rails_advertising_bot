require 'rails_helper'

feature 'Visitor can see account' do
  given!(:account) { create(:my_target_account) }
  given!(:pad) { create(:my_target_pad, account: account) }
  given!(:addunit) { create(:my_target_addunit, pad: pad, format: 8888) }

  scenario 'Visitor trying to see account show view', js: true do
    visit my_target_account_path(account)

    expect(page).to have_link(account.name)
    expect(page).to have_selector('td', text: account.login)
    expect(page).to have_selector('td', text: account.password)
    expect(page).to have_selector('td', text: account.link)
    expect(page).to have_selector('td', text: account.status)
    expect(page).to have_selector("h4#pad-#{pad.id}", text: "#{pad.name}:#{pad.service_id}")
    expect(page).to have_selector("li#addunit-#{addunit.id}", text: "#{addunit.name}:#{addunit.service_id}:#{addunit.format}")

    expect(page).to have_selector('a.new-account-link', text: 'Edit Account')
  end
end
