require 'rails_helper'

feature 'Visitor can see account' do
  given!(:account) { create(:my_target_account) }

  scenario 'Visitor trying to see account show view', js: true do
    visit my_target_account_path(account)

    expect(page).to have_link(account.name)
    expect(page).to have_selector('td', text: account.login)
    expect(page).to have_selector('td', text: account.password)
    expect(page).to have_selector('td', text: account.link)
    expect(page).to have_selector('td', text: account.status)

    expect(page).to have_selector('a.new-account-link', text: 'Edit Account')
  end
end
